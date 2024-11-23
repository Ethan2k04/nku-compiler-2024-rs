//! IR generation from AST.

use super::ast::{
    self,
    BinaryOp,
    BlockItem,
    CompUnit,
    ComptimeVal as Cv,
    ConstDecl,
    ConstDef,
    Decl,
    Exp,
    ExpKind,
    ExpStmt,
    FuncDef,
    FuncFParam,
    Item,
    ReturnStmt,
    Stmt,
    VarDecl,
    VarDef,
    AssignStmt,
    FuncCall,
    LVal,
    UnaryOp,
};
use super::types::{Type, TypeKind as Tk};
use super::symbol_table::{SymbolEntry, SymbolTable};
use crate::infra::linked_list::LinkedListContainer;
use crate::ir::{self, Block, ConstantValue, Context, Func, Global, Inst, IntBinaryOp, FloatBinaryOp, IntCmpCond, FloatCmpCond, CastOp, TargetInfo, Ty, Value};



/// Generate IR from the AST.
pub fn irgen(ast: &CompUnit, pointer_width: u8) -> Context {
    let mut irgen = IrGenContext::default();

    // Set pointer width for target platform
    irgen.ctx.set_target_info(TargetInfo {
        ptr_size: pointer_width as u32,
    });

    // Generate IR
    ast.irgen(&mut irgen);

    // Transfer ownership of the generated IR.
    irgen.finish()
}

/// Generated IR result.
/// Its used to map AST nodes to IR values.
/// It can be either a Global or a Value.
#[derive(Debug, Clone, Copy)]
pub enum IrGenResult {
    Global(Global),
    Value(Value),
}

impl IrGenResult {
    /// Get the value if it is a value.
    ///
    /// # Panics
    /// - Panics if it is a global.
    pub fn unwrap_value(self) -> Value {
        match self {
            IrGenResult::Value(val) => val,
            IrGenResult::Global(_) => unreachable!("expected value"),
        }
    }
}

/// IR generation context.
#[derive(Default)]
pub struct IrGenContext {
    pub ctx: Context,

    // Symbol table
    pub symtable: SymbolTable,

    // Current function and block
    pub curr_func: Option<Func>,
    pub curr_func_name: Option<String>,
    pub curr_block: Option<Block>,

    // Stacks for loop control flow.
    pub loop_entry_stack: Vec<Block>,
    pub loop_exit_stack: Vec<Block>,

    // Return block and slot
    pub curr_ret_slot: Option<Value>,
    pub curr_ret_block: Option<Block>,
}

impl IrGenContext {
    /// Consume the context and return the generated IR.
    pub fn finish(self) -> Context { self.ctx }

    /// Generate a new global constant value in ir given a comptime value in AST.
    fn gen_global_comptime(&mut self, val: &Cv) -> ConstantValue {
        match val {
            Cv::Bool(a) => ConstantValue::i1(&mut self.ctx, *a),
            Cv::Int(a) => ConstantValue::i32(&mut self.ctx, *a as i32),
            Cv::Float(a) => ConstantValue::f32(&mut self.ctx, *a),
            // TODO: Implement list
            Cv::List( .. ) => todo!(),
            // TODO: Implement zero
            Cv::Zero(..) => todo!(),
            Cv::Undef(ty) => {
                let ir_ty = self.gen_type(ty);
                ConstantValue::undef(&mut self.ctx, ir_ty)
            }
        }
    }

    // Generate a new local constant value in ir given a comptime value in AST.
    fn gen_local_comptime(&mut self, val: &Cv) -> Value {
        match val {
            Cv::Bool(a) => Value::i1(&mut self.ctx, *a),
            Cv::Int(a) => Value::i32(&mut self.ctx, *a as i32),
            Cv::Float(a) => Value::f32(&mut self.ctx, *a),
            // TODO: Implement list
            Cv::List(..) => todo!(),
            // TODO: Implement zero
            Cv::Zero(..) => todo!(),
            Cv::Undef(ty) => {
                let ir_ty = self.gen_type(ty);
                Value::undef(&mut self.ctx, ir_ty)
            }
        }
    }

    // Gerate a new type in ir given a type in AST.
    fn gen_type(&mut self, ty: &Type) -> Ty {
        match ty.kind() {
            Tk::Void => Ty::void(&mut self.ctx),
            Tk::Bool => Ty::i1(&mut self.ctx),
            Tk::Int => Ty::i32(&mut self.ctx),
            Tk::Float => Ty::f32(&mut self.ctx),
            Tk::Pointer(..) => Ty::ptr(&mut self.ctx),
            Tk::Array (base, size) => {
                let ir_base = self.gen_type(base);
                Ty::array(&mut self.ctx, ir_base, *size)
            },
            Tk::Func(..) => unreachable!("function type should be handled separately"),
        }
    }

    // Generate a new local expression in ir given an expression in AST.
    fn gen_local_expr(&mut self, exp: &Exp) -> Option<Value> {
        use BinaryOp as Bo;

        let curr_block = self.curr_block.unwrap();

        match &exp.kind {
            // Constants -> generate a local constant value
            ExpKind::Const(v) => Some(self.gen_local_comptime(v)),
            // Binary operations -> generate the operation
            ExpKind::Binary(op, lhs, rhs) => match op {
                Bo::Add
                | Bo::Sub
                | Bo::Mul
                | Bo::Div
                | Bo::Mod
                | Bo::Lt
                | Bo::Gt
                | Bo::Le
                | Bo::Ge
                | Bo::Eq
                | Bo::Ne => {
                    let is_float = lhs.ty().is_float();

                    let lhs = self.gen_local_expr(lhs).unwrap(); // Generate lhs
                    let rhs = self.gen_local_expr(rhs).unwrap(); // Generate rhs

                    let lhs_ty = lhs.ty(&self.ctx);

                    let inst = match op {
                        // Generate add instruction
                        // TODO✔: Implement float binary operations
                        Bo::Add => {
                            if is_float {
                                Inst::float_binary(& mut self.ctx, lhs, rhs, FloatBinaryOp::FAdd, lhs_ty)
                            } else {
                                Inst::int_binary(&mut self.ctx, lhs, rhs, IntBinaryOp::Add, lhs_ty)
                            }
                        },
                        Bo::Sub => {
                            if is_float {
                                Inst::float_binary(&mut self.ctx, lhs, rhs, FloatBinaryOp::FSub, lhs_ty)
                            } else {
                                Inst::int_binary(&mut self.ctx, lhs, rhs, IntBinaryOp::Sub, lhs_ty)
                            }
                        },
                        Bo::Mul => {
                            if is_float {
                                Inst::float_binary(&mut self.ctx, lhs, rhs, FloatBinaryOp::FMul, lhs_ty)
                            } else {
                                Inst::int_binary(&mut self.ctx, lhs, rhs, IntBinaryOp::Mul, lhs_ty)
                            }
                        },
                        Bo::Div => {
                            if is_float {
                                Inst::float_binary(&mut self.ctx, lhs, rhs, FloatBinaryOp::FDiv, lhs_ty)
                            } else {
                                Inst::int_binary(&mut self.ctx, lhs, rhs, IntBinaryOp::SDiv, lhs_ty)
                            }
                        },
                        Bo::Mod => {
                            if is_float {
                                Inst::float_binary(&mut self.ctx, lhs, rhs, FloatBinaryOp::FRem, lhs_ty)
                            } else {
                                Inst::int_binary(&mut self.ctx, lhs, rhs, IntBinaryOp::SRem, lhs_ty)
                            }
                        },
                        Bo::Eq => {
                            let i1_ty = Ty::i1(&mut self.ctx);
                            if is_float {
                                Inst::float_binary(
                                    &mut self.ctx,
                                    lhs,
                                    rhs,
                                    FloatBinaryOp::FCmp { cond : FloatCmpCond::UEq },
                                    i1_ty // 使用i1类型作为结果类型
                                )
                            } else {
                                Inst::int_binary(
                                    &mut self.ctx,
                                    lhs,
                                    rhs,
                                    IntBinaryOp::ICmp { cond : IntCmpCond::Eq },
                                    i1_ty // 使用i1类型作为结果类型
                                )
                            }
                        },
                        Bo::Ne => {
                            let i1_ty = Ty::i1(&mut self.ctx);
                            if is_float {
                                Inst::float_binary(
                                    &mut self.ctx,
                                    lhs,
                                    rhs,
                                    FloatBinaryOp::FCmp { cond : FloatCmpCond::UNe },
                                    i1_ty
                                )
                            } else {
                                Inst::int_binary(
                                    &mut self.ctx,
                                    lhs,
                                    rhs,
                                    IntBinaryOp::ICmp { cond : IntCmpCond::Ne },
                                    i1_ty
                                )
                            }
                        },
                        Bo::Lt => {
                            let i1_ty = Ty::i1(&mut self.ctx);
                            if is_float {
                                Inst::float_binary(
                                    &mut self.ctx,
                                    lhs,
                                    rhs,
                                    FloatBinaryOp::FCmp { cond : FloatCmpCond::ULt },
                                    i1_ty
                                )
                            } else {
                                Inst::int_binary(
                                    &mut self.ctx,
                                    lhs,
                                    rhs,
                                    IntBinaryOp::ICmp { cond : IntCmpCond::Slt },
                                    i1_ty
                                )
                            }
                        },
                        Bo::Le => {
                            let i1_ty = Ty::i1(&mut self.ctx);
                            if is_float {
                                Inst::float_binary(
                                    &mut self.ctx,
                                    lhs,
                                    rhs,
                                    FloatBinaryOp::FCmp { cond : FloatCmpCond::ULe },
                                    i1_ty
                                )
                            } else {
                                Inst::int_binary(
                                    &mut self.ctx,
                                    lhs,
                                    rhs,
                                    IntBinaryOp::ICmp { cond : IntCmpCond::Sle },
                                    i1_ty
                                )
                            }
                        },
                        Bo::Gt => {
                            let i1_ty = Ty::i1(&mut self.ctx);
                            if is_float {
                                Inst::float_binary(
                                    &mut self.ctx,
                                    rhs,
                                    lhs,
                                    FloatBinaryOp::FCmp { cond : FloatCmpCond::ULt },
                                    i1_ty
                                )
                            } else {
                                Inst::int_binary(
                                    &mut self.ctx,
                                    rhs,
                                    lhs,
                                    IntBinaryOp::ICmp { cond : IntCmpCond::Slt },
                                    i1_ty
                                )
                            }
                        },
                        Bo::Ge => {
                            let i1_ty = Ty::i1(&mut self.ctx);
                            if is_float {
                                Inst::float_binary(
                                    &mut self.ctx,
                                    rhs,
                                    lhs,
                                    FloatBinaryOp::FCmp { cond : FloatCmpCond::ULe },
                                    i1_ty
                                )
                            } else {
                                Inst::int_binary(
                                    &mut self.ctx,
                                    rhs,
                                    lhs,
                                    IntBinaryOp::ICmp { cond : IntCmpCond::Sle },
                                    i1_ty
                                )
                            }
                        },
                        Bo::And | Bo::Or => unreachable!()
                        // Bo::And => {
                        //     Inst::int_binary(&mut self.ctx, lhs, rhs, IntBinaryOp::And, lhs_ty)
                        // },
                        // Bo::Or => {
                        //     Inst::int_binary(&mut self.ctx, lhs, rhs, IntBinaryOp::Or, lhs_ty)
                        // },
                    };

                    // Push the instruction to the current block
                    curr_block.push_back(&mut self.ctx, inst).unwrap();
                    Some(inst.result(&self.ctx).unwrap())
                }
                Bo::And | Bo::Or => {
                    // logical-and
                    // - compute lhs
                    // - if lhs is false, jump to merge block with arg = false, otherwise rhs block
                    // - compute rhs, jump to merge block with arg = rhs
                    // - merge block, with an argument, which is the result of the logical-and
                    //
                    // logical-or
                    // - compute lhs
                    // - if lhs is true, jump to merge block with arg = true, otherwise rhs block
                    // - compute rhs, jump to merge block with arg = rhs
                    // - merge block, with an argument, which is the result of the logical-or
                    let lhs = self.gen_local_expr(lhs).unwrap();
                    let lhs_block = self.curr_block.unwrap();

                    let rhs_block = ir::Block::new(&mut self.ctx);
                    let merge_block = ir::Block::new(&mut self.ctx);

                    self.curr_func.unwrap().push_back(&mut self.ctx, rhs_block).unwrap();
                    self.curr_func.unwrap().push_back(&mut self.ctx, merge_block).unwrap();

                    let br = match op {
                        Bo::And => {
                            Inst::cond_br(&mut self.ctx, lhs, rhs_block, merge_block)
                        },
                        Bo::Or => {
                            Inst::cond_br(&mut self.ctx, lhs, merge_block, rhs_block)
                        },
                        _ => unreachable!()
                    };

                    self.curr_block.unwrap().push_back(&mut self.ctx, br).unwrap();

                    self.curr_block = Some(rhs_block);
                    let rhs = self.gen_local_expr(rhs).unwrap();

                    let br = Inst::br(&mut self.ctx, merge_block);
                    self.curr_block.unwrap().push_back(&mut self.ctx, br).unwrap();

                    let i1_ty = Ty::i1(&mut self.ctx);
                    let phi = Inst::phi(&mut self.ctx, i1_ty);

                    match op {
                        Bo::And => {
                            let false_val = Value::i1(&mut self.ctx, false);
                            phi.insert_incoming(&mut self.ctx, lhs_block, false_val);
                            phi.insert_incoming(&mut self.ctx, rhs_block, rhs);
                        }
                        Bo::Or => {
                            let true_val = Value::i1(&mut self.ctx, true);
                            phi.insert_incoming(&mut self.ctx, lhs_block, true_val);
                            if !rhs_block.head(&self.ctx).unwrap().is_phi(&self.ctx) {
                                phi.insert_incoming(&mut self.ctx, self.curr_block.unwrap(), rhs);
                            } else {
                                phi.insert_incoming(&mut self.ctx, rhs_block, rhs);
                            }
                        }
                        _ => unreachable!()
                    }

                    merge_block.push_back(&mut self.ctx, phi).unwrap();
                    self.curr_block = Some(merge_block);
                    Some(phi.result(&self.ctx).unwrap())
                }
            },
            // Unary operations -> generate the operation
            ExpKind::Unary(op, exp) => match op {
                // TODO✔: Implement float unary operations
                UnaryOp::Neg => {
                    let operand = self.gen_local_expr(exp).unwrap();
                    let is_float = exp.ty().is_float();
                    if is_float {
                        let f32_ty = Ty::f32(&mut self.ctx);
                        let zero = Value::f32(&mut self.ctx, 0.0);
                        let sub = Inst::float_binary(
                            &mut self.ctx,
                            zero,      // 被减数(0.0)
                            operand,   // 减数(操作数)
                            FloatBinaryOp::FSub,
                            f32_ty,
                        );
                        curr_block.push_back(&mut self.ctx, sub)
                            .expect("Failed to insert fsub instruction for float negation");
                        Some(sub.result(&self.ctx).unwrap())
                    } else {
                        // %neg = sub i32 0, %value
                        let i32_ty = ir::Ty::i32(&mut self.ctx);
                        let zero = Value::i32(&mut self.ctx, 0);
                        let sub = Inst::int_binary(
                            &mut self.ctx,
                            zero,      // 被减数(0)
                            operand,   // 减数(操作数)
                            IntBinaryOp::Sub,
                            i32_ty,
                        );
                        curr_block.push_back(&mut self.ctx, sub)
                            .expect("Failed to insert sub instruction for negation");
                        Some(sub.result(&self.ctx).unwrap())
                    }
                }
                UnaryOp::Not => {
                    let operand = self.gen_local_expr(exp).unwrap();
                    let i1_ty = Ty::i1(&mut self.ctx);
                    let true_val = Value::i1(&mut self.ctx, true);
                    let xor = Inst::int_binary(
                        &mut self.ctx,
                        operand,
                        true_val,
                        IntBinaryOp::Xor,
                        i1_ty
                    );
                    curr_block.push_back(&mut self.ctx, xor)
                        .expect("Failed to insert xor instruction for logical not");
                    Some(xor.result(&self.ctx).unwrap())
                }
                UnaryOp::Pos => {
                    // do nothing
                    self.gen_local_expr(exp)
                }
            },
            // LValues -> Get the value
            ExpKind::LVal(LVal { ident, ..}) => {
                // TODO: Add support for array indexing
                // Look up the symbol in the symbol table to get the IR value
                let entry = self.symtable.lookup(ident).unwrap();
                let ir_value = entry.ir_value.unwrap();

                let ir_base_ty = self.gen_type(&entry.ty.clone());

                let slot = if let IrGenResult::Global(slot) = ir_value {
                    // If the value is a global, get the global reference
                    let name = slot.name(&self.ctx).to_string();
                    let value_ty = slot.ty(&self.ctx);
                    Value::global_ref(&mut self.ctx, name, value_ty)
                } else if let IrGenResult::Value(slot) = ir_value {
                    // If the value is a local, get the value
                    slot
                } else {
                    unreachable!()
                };

                if slot.is_param(&self.ctx) {
                    // If the value is a parameter, just return the value
                    Some(slot)
                } else {
                    // Otherwise, we need to load the value, generate a load instruction
                    let load = Inst::load(&mut self.ctx, slot, ir_base_ty);
                    curr_block.push_back(&mut self.ctx, load).unwrap();
                    Some(load.result(&self.ctx).unwrap())
                }
            }
            ExpKind::Coercion(expr) => {
                // TODO✔: Implement coercion generation
                let val = self.gen_local_expr(expr).unwrap();
                let from_ty = expr.ty().kind();
                let to_ty = exp.ty().kind();
                match (from_ty, to_ty) {
                    (Tk::Bool, Tk::Int) => {
                        let i32_ty = Ty::i32(&mut self.ctx);
                        let cast = Inst::cast(&mut self.ctx, CastOp::Zext, val, i32_ty);
                        curr_block.push_back(&mut self.ctx, cast).unwrap();
                        Some(cast.result(&self.ctx).unwrap())
                    }
                    (Tk::Int, Tk::Bool) => {
                        let zero = Value::i32(&mut self.ctx, 0);
                        let i1_ty = Ty::i1(&mut self.ctx);
                        let icmp = Inst::int_binary(
                            &mut self.ctx,
                            val,
                            zero,
                            IntBinaryOp::ICmp { cond: IntCmpCond::Ne },
                            i1_ty,
                        );
                        curr_block.push_back(&mut self.ctx, icmp).unwrap();
                        Some(icmp.result(&self.ctx).unwrap())
                    }
                    (Tk::Int, Tk::Float) => {
                        let f32_ty = Ty::f32(&mut self.ctx);
                        let cast = Inst::cast(&mut self.ctx, CastOp::SiToFp, val, f32_ty);
                        curr_block.push_back(&mut self.ctx, cast).unwrap();
                        Some(cast.result(&self.ctx).unwrap())
                    }
                    (Tk::Float, Tk::Int) => {
                        let i32_ty = Ty::i32(&mut self.ctx);
                        let cast = Inst::cast(&mut self.ctx, CastOp::FpToSi, val, i32_ty);
                        curr_block.push_back(&mut self.ctx, cast).unwrap();
                        Some(cast.result(&self.ctx).unwrap())
                    }
                    (Tk::Bool, Tk::Float) => {
                        // bool -> int -> float
                        let i32_ty = Ty::i32(&mut self.ctx);
                        let f32_ty = Ty::f32(&mut self.ctx);

                        // 先创建 zext 指令
                        let zext = Inst::cast(&mut self.ctx, CastOp::Zext, val, i32_ty);
                        curr_block.push_back(&mut self.ctx, zext).unwrap();

                        // 先获取 zext 的结果
                        let zext_result = zext.result(&self.ctx).unwrap();
                        // 再创建 sitofp 指令
                        let to_float = Inst::cast(&mut self.ctx, CastOp::SiToFp, zext_result, f32_ty);
                        curr_block.push_back(&mut self.ctx, to_float).unwrap();

                        Some(to_float.result(&self.ctx).unwrap())
                    }
                    (Tk::Float, Tk::Bool) => {
                        // float -> bool
                        let i1_ty = Ty::i1(&mut self.ctx);
                        let fzero = Value::f32(&mut self.ctx, 0.0);

                        // 先创建 fcmp 指令
                        let fcmp = Inst::float_binary(
                            &mut self.ctx,
                            val,
                            fzero,
                            FloatBinaryOp::FCmp { cond: FloatCmpCond::UNe },
                            i1_ty,
                        );
                        curr_block.push_back(&mut self.ctx, fcmp).unwrap();
                        Some(fcmp.result(&self.ctx).unwrap())
                    }
                    (Tk::Array(..), Tk::Pointer(_)) => self.gen_local_expr(expr),
                    _ => unreachable!("invalid coercion: {:#?} -> {:#?}", from_ty, to_ty),
                }
            }
            ExpKind::FuncCall(FuncCall { ident, args }) => {
                // TODO✔: Implement function call generation
                let ir_args = args
                    .iter()
                    .map(|arg| self.gen_local_expr(arg).unwrap())
                    .collect();

                let ty = exp.ty();
                let ir_ty = self.gen_type(ty);
                let call = Inst::call(&mut self.ctx, ident.clone(), ir_args, ir_ty);
                curr_block.push_back(&mut self.ctx, call).expect("Failed to insert call instruction");

                if !ty.is_void() {
                    call.result(&self.ctx)
                } else {
                    None
                }
            }
            ExpKind::InitList(_) => unreachable!(),
        }
    }

    // Generate the system library function definitions.
    fn gen_sysylib(&mut self) {
        // TODO✔: Implement gen_sysylib
        // Since the system library is linked in the linking phase, we just need
        // to generate declarations here.
        // 1. 首先注册所有系统库函数到符号表
        self.symtable.register_sysylib();

        // 2. 创建基本类型，后面会用到
        let void = Ty::void(&mut self.ctx);
        let i32 = Ty::i32(&mut self.ctx);
        let f32 = Ty::f32(&mut self.ctx);
        let ptr = Ty::ptr(&mut self.ctx);

        // 3. 为每个系统库函数生成函数声明
        let fn_decls = vec![
            ("getint", vec![], i32),                   // int getint()
            ("putint", vec![i32], void),               // void putint(int)
            ("getch", vec![], i32),                    // int getch()
            ("putch", vec![i32], void),                // void putch(int)
            ("getfloat", vec![], f32),                 // float getfloat()
            ("putfloat", vec![f32], void),             // void putfloat(float)
            ("getarray", vec![ptr], i32),              // int getarray(int[])
            ("putarray", vec![i32, ptr], void),        // void putarray(int, int[])
            ("getfarray", vec![ptr], i32),             // int getfarray(float[])
            ("putfarray", vec![i32, ptr], void),       // void putfarray(int, float[])
            ("starttime", vec![i32], void),            // void _sysy_starttime(int)
            ("stoptime", vec![i32], void),             // void _sysy_stoptime(int)
        ];

        // 4. 生成函数定义
        for (name, param_tys, ret_ty) in fn_decls {
            let func = Func::declare(&mut self.ctx, name.to_string(), ret_ty);

            // 为每个参数添加类型
            for param_ty in param_tys {
                func.add_param(&mut self.ctx, param_ty);
            }
        }

        // 5. 生成内存操作函数(来自libc)
        // void* memset(void* str, int c, size_t n)
        let memset = Func::declare(&mut self.ctx, "memset".to_string(), void);
        memset.add_param(&mut self.ctx, ptr);  // dest
        memset.add_param(&mut self.ctx, i32);  // value
        memset.add_param(&mut self.ctx, i32);  // size

        // void* memcpy(void* dest, const void* src, size_t n)
        let memcpy = Func::declare(&mut self.ctx, "memcpy".to_string(), void);
        memcpy.add_param(&mut self.ctx, ptr);  // dest
        memcpy.add_param(&mut self.ctx, ptr);  // src
        memcpy.add_param(&mut self.ctx, i32);  // size
    }
}

pub trait IrGen {
    fn irgen(&self, irgen: &mut IrGenContext);
}

impl IrGen for CompUnit {
    // Generate IR for the compilation unit.
    fn irgen(&self, irgen: &mut IrGenContext) {
        // Enter the global scope
        irgen.symtable.enter_scope();
        // Generate system library function definitions
        irgen.gen_sysylib();
        // Generate IR for each item in the compilation unit
        for item in &self.items {
            item.irgen(irgen);
        }
        // Leave the global scope
        irgen.symtable.leave_scope();
    }
}


impl IrGen for Item {
    // Generate IR for an item.
    fn irgen(&self, irgen: &mut IrGenContext) {
        match self {
            Item::Decl(decl) => match decl {
                Decl::ConstDecl(ConstDecl { defs, .. }) => {
                    for ConstDef {ident, init, ..} in defs {
                        // Try to fold the initializer to get the constant value
                        // Note for const declaration, the initializer must be a constant
                        let comptime = init
                            .try_fold(&irgen.symtable)
                            .expect("global def expected to have constant initializer");
                        // Generate the constant value in IR
                        let constant = irgen.gen_global_comptime(&comptime);
                        let slot = Global::new(
                            &mut irgen.ctx,
                            format!("__GLOBAL_CONST_{}", ident),
                            constant,
                        );
                        // Insert the symbol in the symbol table
                        irgen.symtable.insert(
                            ident.clone(),
                            SymbolEntry {
                                ty: init.ty().clone(),
                                comptime: Some(comptime),
                                ir_value: Some(IrGenResult::Global(slot)),
                            },
                        );
                    }                    
                }
                Decl::VarDecl(VarDecl { defs, .. }) => {
                    for VarDef { ident, init, .. } in defs {
                        // Note that if the variable is defined without an initializer, aka,
                        // Undefined, we should already assigned their init as `None` in type
                        // checking phase.
                        let comptime = init
                            .as_ref()
                            .unwrap() // Safe to unwrap since we already checked it in type checking phase
                            .try_fold(&irgen.symtable)
                            .expect("global def expected to have constant initializer");
                        // Generate the constant value in IR
                        let constant = irgen.gen_global_comptime(&comptime);
                        let slot = Global::new(
                            &mut irgen.ctx,
                            format!("__GLOBAL_VAR_{}", ident),
                            constant,
                        );
                        // Insert the symbol in the symbol table
                        irgen.symtable.insert(
                            ident.clone(),
                            SymbolEntry {
                                ty: init.as_ref().unwrap().ty().clone(),
                                comptime: Some(comptime),
                                ir_value: Some(IrGenResult::Global(slot)),
                            },
                        );
                    }
                }
            },
            Item::FuncDef(func) => func.irgen(irgen),
        }
    }
}


impl IrGen for FuncDef {
    fn irgen(&self, irgen: &mut IrGenContext) {
        irgen.symtable.enter_scope();

        let mut param_tys = Vec::new();
        for FuncFParam { ty, .. } in self.params.iter() {
            param_tys.push(ty.clone());
        }

        let func_ty = Type::func(param_tys.clone(), self.ret_ty.clone());

        let ir_ret_ty = irgen.gen_type(&self.ret_ty);
        let func = Func::new(&mut irgen.ctx, self.ident.clone(), ir_ret_ty);

        irgen.symtable.insert_upper(
            self.ident.clone(),
            SymbolEntry {
                ty: func_ty,
                comptime: None,
                ir_value: None,
            },
            1,
        );

        let block = Block::new(&mut irgen.ctx);
        func.push_back(&mut irgen.ctx, block).unwrap();

        irgen.curr_func = Some(func);
        irgen.curr_func_name = Some(self.ident.clone());
        irgen.curr_block = Some(block);

        // block params
        for (FuncFParam { ident, .. }, ty) in self.params.iter().zip(param_tys.iter()) {
            let ir_ty = irgen.gen_type(ty);
            let param = func.add_param(&mut irgen.ctx, ir_ty);

            irgen.symtable.insert(
                ident.clone(),
                SymbolEntry {
                    ty: ty.clone(),
                    comptime: None,
                    ir_value: Some(IrGenResult::Value(param)),
                },
            );
        }

        // create slots for pass-by-value params
        for (FuncFParam { ident, .. }, ty) in self.params.iter().zip(param_tys.iter()) {
            if ty.is_int() {
                let ir_ty = irgen.gen_type(ty);
                let slot = Inst::alloca(&mut irgen.ctx, ir_ty);

                block.push_front(&mut irgen.ctx, slot).unwrap();
                let slot = slot.result(&irgen.ctx).unwrap();

                // get old entry
                let param = irgen
                    .symtable
                    .lookup(ident)
                    .unwrap()
                    .ir_value
                    .unwrap()
                    .unwrap_value();

                // store
                let store = Inst::store(&mut irgen.ctx, param, slot);

                block.push_back(&mut irgen.ctx, store).unwrap();

                // set new entry
                irgen.symtable.insert(
                    ident.clone(),
                    SymbolEntry {
                        ty: ty.clone(),
                        comptime: None,
                        ir_value: Some(IrGenResult::Value(slot)),
                    },
                );
            }
        }

        // create return block and slot
        let ret_block = Block::new(&mut irgen.ctx);
        irgen.curr_ret_block = Some(ret_block);

        if !self.ret_ty.is_void() {
            let ir_ret_ty = irgen.gen_type(&self.ret_ty);
            let ret_slot = Inst::alloca(&mut irgen.ctx, ir_ret_ty);

            block.push_front(&mut irgen.ctx, ret_slot).unwrap();
            irgen.curr_ret_slot = Some(ret_slot.result(&irgen.ctx).unwrap());
        }

        // generate body
        self.body.irgen(irgen);

        // 如果没有返回语句，添加一个
        if let Some(curr) = irgen.curr_block {
            if let Some(last_inst) = curr.tail(&irgen.ctx) {
                if !last_inst.is_terminator(&irgen.ctx) {
                    let br = Inst::br(&mut irgen.ctx, ret_block);
                    curr.push_back(&mut irgen.ctx, br).unwrap();
                }
            }
        }

        // append return block
        func.push_back(&mut irgen.ctx, ret_block).unwrap();

        if !self.ret_ty.is_void() {
            // load, ret
            let ret_slot = irgen.curr_ret_slot.unwrap();
            let ty = irgen.gen_type(&self.ret_ty);

            let load = Inst::load(&mut irgen.ctx, ret_slot, ty);
            ret_block.push_back(&mut irgen.ctx, load).unwrap();
            let val = load.result(&irgen.ctx).unwrap();

            let ret = Inst::ret(&mut irgen.ctx, Some(val));
            ret_block.push_back(&mut irgen.ctx, ret).unwrap();
        } else {
            // just return
            let ret = Inst::ret(&mut irgen.ctx, None);
            ret_block.push_back(&mut irgen.ctx, ret).unwrap();
        }

        irgen.curr_func = None;
        irgen.curr_func_name = None;
        irgen.curr_block = None;
        irgen.curr_ret_slot = None;
        irgen.curr_ret_block = None;

        irgen.symtable.leave_scope();
    }
}

impl IrGen for Decl {
    fn irgen(&self, irgen: &mut IrGenContext) {
        let entry_block = irgen.curr_func.unwrap().head(&irgen.ctx).unwrap();
        let curr_block = irgen.curr_block.unwrap();
        match self {
            Decl::ConstDecl(ConstDecl { defs, .. }) => {
                for ConstDef { ident, init, .. } in defs {
                    let comptime = init
                        .try_fold(&irgen.symtable)
                        .expect("global def expected to have constant initializer");

                    let ir_ty = irgen.gen_type(init.ty());
                    let stack_slot = Inst::alloca(&mut irgen.ctx, ir_ty);

                    entry_block.push_front(&mut irgen.ctx, stack_slot).unwrap();
                    irgen.symtable.insert(
                        ident,
                        SymbolEntry {
                            ty: init.ty().clone(),
                            comptime: Some(comptime),
                            ir_value: Some(IrGenResult::Value(
                                stack_slot.result(&irgen.ctx).unwrap(),
                            )),
                        },
                    );
                    let init = irgen.gen_local_expr(init).unwrap();
                    let slot = stack_slot.result(&irgen.ctx).unwrap();
                    let store = Inst::store(&mut irgen.ctx, init, slot);
                    curr_block.push_back(&mut irgen.ctx, store).unwrap();
                }
            }
            Decl::VarDecl(VarDecl { defs, .. }) => {
                for VarDef { ident, init, .. } in defs {
                    let init = init.as_ref().unwrap();
                    let ir_ty = irgen.gen_type(init.ty());
                    let stack_slot = Inst::alloca(&mut irgen.ctx, ir_ty);

                    entry_block.push_front(&mut irgen.ctx, stack_slot).unwrap();
                    irgen.symtable.insert(
                        ident,
                        SymbolEntry {
                            ty: init.ty().clone(),
                            comptime: None,
                            ir_value: Some(IrGenResult::Value(
                                stack_slot.result(&irgen.ctx).unwrap(),
                            )),
                        },
                    );

                    let init = irgen.gen_local_expr(init).unwrap();
                    let slot = stack_slot.result(&irgen.ctx).unwrap();
                    let store = Inst::store(&mut irgen.ctx, init, slot);
                    curr_block.push_back(&mut irgen.ctx, store).unwrap();
                }
            }
        }
    }
}

impl IrGen for ast::Block {
    fn irgen(&self, irgen: &mut IrGenContext) {
        irgen.symtable.enter_scope();
        for item in self.items.iter() {
            match item {
                BlockItem::Decl(decl) => decl.irgen(irgen),
                BlockItem::Stmt(stmt) => stmt.irgen(irgen),
            }
        }
        irgen.symtable.leave_scope();
    }
}

impl IrGen for Stmt {
    fn irgen(&self, irgen: &mut IrGenContext) {
        let curr_block = irgen.curr_block.unwrap();

        match self {
            Stmt::Assign(AssignStmt { lval: LVal { ident, .. }, exp }) => {
                // XXX: Add support for array indexing, Not sure if we need to implement it
                let entry = irgen.symtable.lookup(ident).unwrap();
                let ir_value = entry.ir_value.unwrap();

                let slot = if let IrGenResult::Global(slot) = ir_value {
                    let name = slot.name(&irgen.ctx).to_string();
                    let value_ty = slot.ty(&irgen.ctx);
                    Value::global_ref(&mut irgen.ctx, name, value_ty)
                } else if let IrGenResult::Value(slot) = ir_value {
                    slot
                } else {
                    unreachable!()
                };

                let store_dst = slot;

                let val = irgen.gen_local_expr(exp).unwrap();
                let store = Inst::store(&mut irgen.ctx, val, store_dst);
                curr_block.push_back(&mut irgen.ctx, store).unwrap();
            }
            Stmt::Exp(ExpStmt { exp }) => {
                if let Some(ref exp) = exp {
                    irgen.gen_local_expr(exp);
                }
            }
            Stmt::Block(block) => block.irgen(irgen),
            Stmt::If(if_stmt) => {
                let cond = irgen.gen_local_expr(&if_stmt.cond).unwrap();
                let curr_block = irgen.curr_block.unwrap();
                let curr_func = irgen.curr_func.unwrap();

                let then_block = Block::new(&mut irgen.ctx);
                let merge_block = Block::new(&mut irgen.ctx);
                let else_block = if if_stmt.else_.is_some() {
                    Some(Block::new(&mut irgen.ctx))
                } else {
                    None
                };

                curr_func.push_back(&mut irgen.ctx, then_block).unwrap();
                if let Some(else_block) = else_block {
                    curr_func.push_back(&mut irgen.ctx, else_block).unwrap();
                }
                curr_func.push_back(&mut irgen.ctx, merge_block).unwrap();

                // 生成条件跳转
                let br = Inst::cond_br(&mut irgen.ctx, cond, then_block,
                                       else_block.unwrap_or(merge_block));
                curr_block.push_back(&mut irgen.ctx, br).unwrap();

                let mut is_terminator_then = false;
                let mut is_terminator_else = false;
                // 生成then分支代码
                irgen.curr_block = Some(then_block);
                if_stmt.then.irgen(irgen);
                // 检查then块是否已经有终结指令
                if let Some(curr) = irgen.curr_block {
                    if let Some(last_inst) = curr.tail(&irgen.ctx) {
                        if !last_inst.is_terminator(&irgen.ctx) {
                            // 如果没有终结指令，添加跳转到merge块的指令
                            let br = Inst::br(&mut irgen.ctx, merge_block);
                            curr.push_back(&mut irgen.ctx, br).unwrap();
                        } else {
                            is_terminator_then = true;
                        }
                    } else {
                        let jump = Inst::br(&mut irgen.ctx, merge_block);
                        irgen.curr_block.unwrap().push_back(&mut irgen.ctx, jump).unwrap();
                    }
                }

                // 生成else分支代码(如果有)
                if let Some(else_stmt) = &if_stmt.else_ {
                    let else_block = else_block.unwrap();
                    irgen.curr_block = Some(else_block);
                    else_stmt.irgen(irgen);
                    // 检查else块是否已经有终结指令
                    if let Some(curr) = irgen.curr_block {
                        if let Some(last_inst) = curr.tail(&irgen.ctx) {
                            if !last_inst.is_terminator(&irgen.ctx) {
                                // 如果没有终结指令，添加跳转到merge块的指令
                                let br = Inst::br(&mut irgen.ctx, merge_block);
                                curr.push_back(&mut irgen.ctx, br).unwrap();
                            } else {
                                is_terminator_else = true;
                            }
                        }
                    }
                } else {
                    // 如果没有else分支，条件跳转已经处理了跳转到merge块的情况
                }

                // 如果then和else块都有终结指令，merge 块添加一个无条件跳转
                if is_terminator_then && is_terminator_else {
                    let br = Inst::br(&mut irgen.ctx, irgen.curr_ret_block.unwrap());
                    merge_block.push_back(&mut irgen.ctx, br).unwrap();
                } else {
                    // hack: 如果merge块没有指令，LLVM会报错，这里添加一个nop指令
                    let i1_ty = Ty::i1(&mut irgen.ctx);
                    let nop = Inst::alloca(&mut irgen.ctx, i1_ty);
                    merge_block.push_back(&mut irgen.ctx, nop).unwrap();
                }

                irgen.curr_block = Some(merge_block);

            }
            Stmt::While(while_stmt) => {
                // TODO✔: Implement while statement, maybe something wrong here
                // 1. 创建所需的基本块
                let loop_entry = Block::new(&mut irgen.ctx);  // 条件判断块
                let loop_body = Block::new(&mut irgen.ctx);   // 循环体块
                let loop_exit = Block::new(&mut irgen.ctx);   // 退出块

                // 2. 从当前块跳转到条件判断块
                let br = Inst::br(&mut irgen.ctx, loop_entry);
                irgen.curr_block.unwrap().push_back(&mut irgen.ctx, br)
                    .expect("Failed to insert branch to loop entry block");

                // 3. 将条件判断块加入函数
                irgen.curr_func.unwrap()
                    .push_back(&mut irgen.ctx, loop_entry)
                    .expect("Failed to append loop entry block");

                // 4. 生成条件判断代码
                irgen.curr_block = Some(loop_entry);
                let cond = irgen.gen_local_expr(&while_stmt.cond).unwrap();

                

                // 5. 根据条件跳转到循环体或退出块
                let cond_br = Inst::cond_br(&mut irgen.ctx, cond, loop_body, loop_exit);
                irgen.curr_block.unwrap().push_back(&mut irgen.ctx, cond_br)
                    .expect("Failed to insert conditional branch");

                // 6. 生成循环体代码
                irgen.curr_func.unwrap()
                    .push_back(&mut irgen.ctx, loop_body)
                    .expect("Failed to append loop body block");
                irgen.curr_block = Some(loop_body);

                // 保存当前循环的入口和出口块,用于break和continue
                irgen.loop_entry_stack.push(loop_entry);
                irgen.loop_exit_stack.push(loop_exit);

                &while_stmt.body.irgen(irgen);  // 生成循环体的IR

                // 从循环体块跳回条件判断块
                let br_back = Inst::br(&mut irgen.ctx, loop_entry);
                irgen.curr_block.unwrap()
                    .push_back(&mut irgen.ctx, br_back)
                    .expect("Failed to insert branch back to entry");

                // 恢复loop stack
                irgen.loop_entry_stack.pop();
                irgen.loop_exit_stack.pop();

                // 7. 最后设置当前块为退出块
                irgen.curr_func.unwrap()
                    .push_back(&mut irgen.ctx, loop_exit)
                    .expect("Failed to append loop exit block");
                irgen.curr_block = Some(loop_exit);

                // hack: 如果退出块没有指令，LLVM会报错，这里添加一个nop指令
                // I have no idea, but I'm deeply shocked
                let i1_ty = Ty::i1(&mut irgen.ctx);
                let nop = Inst::alloca(&mut irgen.ctx, i1_ty);
                loop_exit.push_back(&mut irgen.ctx, nop).unwrap();

            }
            Stmt::Break => {
                // TODO✔: Implement break statement
                // 检查是否在循环中
                let exit_block = irgen.loop_exit_stack.last().expect("break outside of loop");

                // 生成跳转指令到循环的退出块
                let br = Inst::br(&mut irgen.ctx, *exit_block);
                irgen.curr_block.unwrap()
                    .push_back(&mut irgen.ctx, br)
                    .expect("Failed to insert break branch instruction");
            }
            Stmt::Continue => {
                // TODO✔: Implement continue statement
                // 检查是否在循环中
                let entry_block = irgen.loop_entry_stack.last().expect("continue outside of loop");

                // 生成跳转指令到循环的条件判断块
                let br = Inst::br(&mut irgen.ctx, *entry_block);
                irgen.curr_block.unwrap()
                    .push_back(&mut irgen.ctx, br)
                    .expect("Failed to insert continue branch instruction");
            }
            Stmt::Return(ReturnStmt { exp }) => {
                if let Some(exp) = exp {
                    let val = irgen.gen_local_expr(exp).unwrap();
                    let store = Inst::store(&mut irgen.ctx, val, irgen.curr_ret_slot.unwrap());
                    irgen
                        .curr_block
                        .unwrap()
                        .push_back(&mut irgen.ctx, store)
                        .unwrap();
                }

                let jump = Inst::br(&mut irgen.ctx, irgen.curr_ret_block.unwrap());
                irgen
                    .curr_block
                    .unwrap()
                    .push_back(&mut irgen.ctx, jump)
                    .unwrap();
            }
        }
    }
}