//! Target Code Generation.
//!
//! The assembly code is generated here.

use std::collections::HashMap;
use std::f32::MIN;

use super::block::MBlock;
use super::context::MContext;
use super::func::{MFunc, MLabel};
use super::imm::{self, Imm12};
use super::inst::{AluOpRRI, AluOpRRR, LoadOp, MInst, MInstKind, StoreOp, BrOp};
use super::operand::{MOperand, MOperandKind, MemLoc};
use super::regs::{self, Reg, RegKind, PReg};
use crate::infra::linked_list::{LinkedListContainer, LinkedListNode};
use crate::infra::storage::ArenaPtr;
use crate::ir::{self, ConstantValue, FuncKind, IntBinaryOp, Ty, Value};
use crate::backend::context::RawData;
use crate::utils::cfg::*;
use crate::utils::dominance::Dominance;

pub struct CodegenContext<'s> {
    /// The machine code context.
    pub(super) mctx: MContext,
    /// The IR context.
    pub(super) ctx: &'s ir::Context,
    /// The mapping from IR value to machine code operand.
    pub(super) lowered: HashMap<ir::Value, MOperand>,

    /// The function mapping.
    ///
    /// We want to get machine function by the name when generating call
    /// instruction, so simply map the function name to the machine function.
    pub funcs: HashMap<String, MFunc>,

    /// Mapping IR blocks to machine blocks.
    pub blocks: HashMap<ir::Block, MBlock>,

    /// Other global labels, for global variables/constants.
    pub globals: HashMap<String, MLabel>,

    /// The current function.
    pub(super) curr_func: Option<MFunc>,
    /// The current block.
    pub(super) curr_block: Option<MBlock>,

    /// The block label counter.
    ///
    /// In case the name of blocks are not provided, we generate a unique label
    /// as the name.
    label_counter: u32,

    // 用于寄存器分配
    live_intervals: HashMap<Reg, LiveInterval>,
    inst_index: usize,  // 指令编号
}

impl<'s> CodegenContext<'s> {
    pub fn new(ctx: &'s ir::Context) -> Self {
        Self {
            mctx: MContext::default(),
            ctx,
            lowered: HashMap::default(),
            funcs: HashMap::default(),
            blocks: HashMap::default(),
            globals: HashMap::default(),
            curr_func: None,
            curr_block: None,
            label_counter: 0,
            live_intervals: HashMap::new(),
            inst_index: 0,
        }
    }

    /// Finish the code generation and return the machine code context.
    pub fn finish(self) -> MContext { self.mctx }

    /// Get a reference to the machine code context.
    pub fn mctx(&self) -> &MContext { &self.mctx }

    /// Get a mutable reference to the machine code context.
    pub fn mctx_mut(&mut self) -> &mut MContext { &mut self.mctx }

    fn should_use_bss(&self, elems: &[ir::ConstantValue]) -> bool {
        // 检查数组是否全部是0或未初始化
        elems.iter().all(|elem| match elem {
            ir::ConstantValue::Int32 { value, .. } => *value == 0,
            ir::ConstantValue::Float32 { value, .. } => *value == 0.0,
            ir::ConstantValue::Array { elems, .. } => self.should_use_bss(elems),
            ir::ConstantValue::Undef { .. } => true,
            ir::ConstantValue::AggregateZero { .. } => true,
            _ => false,
        })
    }

    fn process_array_elements(&self, values: &mut Vec<u32>, elems: &[ir::ConstantValue]) {
        for elem in elems {
            match elem {
                ir::ConstantValue::Int32 { value, .. } => {
                    values.push(*value as u32);
                }
                ir::ConstantValue::Float32 { value, .. } => {
                    values.push(value.to_bits());
                }
                ir::ConstantValue::Array { elems, .. } => {
                    self.process_array_elements(values, elems);
                }
                ir::ConstantValue::Undef { .. } => {
                    values.push(0);
                }
                ir::ConstantValue::AggregateZero { ty } => {
                    let size = ty.bitwidth(self.ctx) / 32;
                    values.extend(std::iter::repeat(0).take(size));
                }
                _ => unreachable!("unsupported array element type"),
            }
        }
    }

    /// Do the code generation.
    pub fn codegen(&mut self) {
        // Generate plcaceholders for all the functions and blocks.
        for func in self.ctx.funcs() {
            let name = func.name(self.ctx);
            let label = MLabel::from(name);

            let is_external = match func.kind(self.ctx) {
                FuncKind::Declare => true,
                FuncKind::Define => false,
            };

            if is_external {
                let mfunc = MFunc::new_declare(&mut self.mctx, label);
                self.funcs.insert(name.to_string(), mfunc);
                continue;
            } else {
                let mfunc = MFunc::new(&mut self.mctx, label); 
                self.funcs.insert(name.to_string(), mfunc);
    
                // 生成所有基本块的占位符
                for block in func.iter(self.ctx) {
                    let mblock = MBlock::new(&mut self.mctx, format!(".L{}", block.rv_name(self.ctx)));
                    let _ = mfunc.push_back(&mut self.mctx, mblock);
                    self.blocks.insert(block, mblock);
                }
            }
        }

        
        // TODO: There are several things to be handled before translating instructions:
        //  1. External functions and corresponding signatures.
        //  2. Global variables/constants.

        for global_data in self.ctx.globals.iter() {
            let global_name = &global_data.name;
            let global_label = MLabel::from(format!("{}", global_name));
            self.globals.insert(global_name.to_string(), global_label.clone());
        
            match &global_data.value {
                ir::ConstantValue::Int32 { value, .. } => {
                    if *value == 0 {
                        // 0初始化放在BSS段
                        self.mctx.add_raw_data(global_label, RawData::Bss(4));
                    } else {
                        self.mctx.add_raw_data(global_label, RawData::Words(vec![*value as u32]));
                    }
                }
                ir::ConstantValue::Float32 { value, .. } => {
                    if *value == 0.0 {
                        // 0.0初始化放在BSS段
                        self.mctx.add_raw_data(global_label, RawData::Bss(4));
                    } else {
                        self.mctx.add_raw_data(global_label, RawData::Words(vec![value.to_bits()]));
                    }
                }
                ir::ConstantValue::Array { elems, ty } => {
                    if self.should_use_bss(elems) {
                        // 如果数组全是0或未初始化,放在BSS段
                        let size = ty.bitwidth(self.ctx) / 8;
                        self.mctx.add_raw_data(global_label, RawData::Bss(size));
                    } else {
                        let mut values = Vec::new();
                        self.process_array_elements(&mut values, elems);
                        self.mctx.add_raw_data(global_label, RawData::Words(values));
                    }
                }
                ir::ConstantValue::Undef { ty } | ir::ConstantValue::AggregateZero { ty } => {
                    // 未初始化和零初始化都放在BSS段
                    let size = ty.bitwidth(self.ctx) / 8;
                    self.mctx.add_raw_data(global_label, RawData::Bss(size));
                }
                _ => unimplemented!("unsupported global variable type"),
            }
        }
        

        // XXX: This is just a demonstration, you may refactor this part entirely.
        for func in self.ctx.funcs() {
            self.curr_func = Some(self.funcs[func.name(self.ctx)]);
            let mfunc = self.curr_func.unwrap();

            if mfunc.is_external(&self.mctx) {
                continue;
            }

            // TODO: Incoming parameters can be handled here.

            // XXX: You can use dominance/cfg to generate better assembly.

            // Translate the instructions.
            let cfg = CfgInfo::new(self.ctx, func);
            let dom = Dominance::new(self.ctx, &cfg);
            for block in dom.rpo() {
                self.curr_block = Some(self.blocks[&block]);
                let mblock = self.curr_block.unwrap();

                let entry = func.entry_node(self.ctx);
                if entry == *block {
                    self.gen_incoming(func);
                }

                
                for inst in block.iter(self.ctx) {
                    // TODO: Translate the instruction.
                    match inst.kind(self.ctx) {
                        ir::InstKind::Alloca { ty } => {
                            // Allocate space on the stack.
                            let size = (ty.bitwidth(self.ctx) + 7) / 8;
                            mfunc.add_storage_stack_size(&mut self.mctx, size as u64);
                            // Because the stack grows downward, we need to use negative offset.
                            let offset = -(mfunc.storage_stack_size(&self.mctx) as i64);
                            let mem_loc = MemLoc::Slot { offset };
                            let ty = inst.result(self.ctx).unwrap().ty(self.ctx);
                            let mopd = MOperand {
                                ty,
                                kind: MOperandKind::Mem(mem_loc),
                            };
                            // Insert the result into the lowered map.
                            self.lowered.insert(inst.result(self.ctx).unwrap(), mopd);
                        }
                        ir::InstKind::Store => {
                            let val = inst.operand(self.ctx, 0);
                            let ptr = inst.operand(self.ctx, 1);

                            if let ir::ValueKind::Constant { value } = &ptr.try_deref(self.ctx).unwrap().kind {
                                if let ConstantValue::GlobalRef { name, .. } = value {
                                    // 是全局变量,先加载地址
                                    let addr_reg = self.mctx.new_vreg(RegKind::General).into();
                                    let la = MInst::build_la(&mut self.mctx, addr_reg, self.globals[name].clone());
                                    self.curr_block.unwrap().push_back(&mut self.mctx, la).unwrap();
                        
                                    // 存储到全局变量地址
                                    let mem_loc = MemLoc::RegOffset {
                                        base: addr_reg,
                                        offset: 0
                                    };
                                    self.gen_store(val, mem_loc);
                                    continue;;
                                }
                            }

                            let mem_loc = match self.lowered[&ptr].kind {
                                MOperandKind::Mem(mem_loc) => mem_loc,
                                _ => unreachable!(),
                            };
                            // Here we use a helper function to generate the store instruction.
                            // You can change the implementation of the helper functions as you
                            // like. Or you can also not use helper functions.
                            self.gen_store(val, mem_loc);
                        }
                        ir::InstKind::Load => {
                            let ptr = inst.operand(self.ctx, 0);

                            let ty = inst.result(self.ctx).unwrap().ty(self.ctx);

                            // 先检查是否加载自全局变量
                            if let ir::ValueKind::Constant { value } = &ptr.try_deref(self.ctx).unwrap().kind {
                                if let ConstantValue::GlobalRef { name, .. } = value {
                                    // 是全局变量,先加载地址
                                    let addr_reg = self.mctx.new_vreg(RegKind::General).into();
                                    let la = MInst::build_la(&mut self.mctx, addr_reg, self.globals[name].clone());
                                    self.curr_block.unwrap().push_back(&mut self.mctx, la).unwrap();

                                    // 从全局变量地址加载
                                    let mem_loc = MemLoc::RegOffset {
                                        base: addr_reg,
                                        offset: 0
                                    };
                                    let mopd = self.gen_load(ty, mem_loc); 
                                    self.lowered.insert(inst.result(self.ctx).unwrap(), mopd);
                                    continue;
                                }
                            }

                            let mem_loc = match self.lowered[&ptr].kind {
                                MOperandKind::Reg(reg) => MemLoc::RegOffset {
                                    base: reg,
                                    offset: 0,
                                },
                                MOperandKind::Mem(mem_loc) => mem_loc,
                                MOperandKind::Imm(..) => unreachable!(),
                                MOperandKind::Undef => todo!("load from undef"),
                                // There might be other cases, but i'll just panic for now.
                            };
                            let ty = inst.result(self.ctx).unwrap().ty(self.ctx);
                            let mopd = self.gen_load(ty, mem_loc);
                            self.lowered.insert(inst.result(self.ctx).unwrap(), mopd);
                        }
                        ir::InstKind::IntBinary { op } => {
                            // TODO: Here's a simple example, you may need to handle more cases.
                            let lhs = inst.operand(self.ctx, 0);
                            let rhs = inst.operand(self.ctx, 1);
                            let mopd = self.gen_int_binary(*op, lhs, rhs);
                            self.lowered.insert(inst.result(self.ctx).unwrap(), mopd);
                        }
                        ir::InstKind::FloatBinary { op } => {
                            todo!()
                        }
                        ir::InstKind::Ret => {
                            // TODO: You can handle multiple return values as you like.
                            // if inst.operand_iter(self.ctx).count() == 1 {
                            //     let val = inst.operand(self.ctx, 0);
                            //     self.gen_ret_move(val);
                            // }
                            // The `ret` should be generated in function
                            // epilogue, after register allocation.
                            match inst.operand_iter(self.ctx).count() {
                                0 => {
                                    // 返回void,不需要处理返回值
                                }
                                1 => {
                                    // 单个返回值
                                    let val = inst.operand(self.ctx, 0);
                                    self.gen_ret_move(val);
                                }
                                _ => unreachable!("Multiple return values not supported"),
                            }
                            // 实际的return指令会在函数epilogue中生成
                        }
                        &ir::InstKind::Br => {
                            if inst.operand_iter(self.ctx).count() == 0 {
                                // 无条件跳转
                                let target = inst.successor(self.ctx, 0);
                                self.gen_br(target);
                            } else {
                                // 条件跳转
                                let cond = inst.operand(self.ctx, 0);
                                let then_bb = inst.successor(self.ctx, 0);
                                let else_bb = inst.successor(self.ctx, 1);
                                self.gen_cond_br(cond, then_bb, else_bb);
                            }
                        }
                        
                        &ir::InstKind::CondBr => {
                            let cond = inst.operand(self.ctx, 0);
                            let then_bb = inst.successor(self.ctx, 0);
                            let else_bb = inst.successor(self.ctx, 1);
                            self.gen_cond_br(cond, then_bb, else_bb);
                        }
                        ir::InstKind::Cast { op } => {
                            let val = inst.operand(self.ctx, 0);
                            let target_ty = inst.result(self.ctx).unwrap().ty(self.ctx);
                            let mopd = self.gen_cast(op, val, target_ty);
                            self.lowered.insert(inst.result(self.ctx).unwrap(), mopd);
                        }
                        ir::InstKind::Call { name } => {
                            let curr_block = self.curr_block.unwrap();
                            let curr_func = self.curr_func.unwrap();
                            
                            let callee = self.funcs[name];
                            let mut int_reg_count = 0;  // 用于跟踪已使用的整数参数寄存器
                            let mut float_reg_count = 0;  // 用于跟踪已使用的浮点参数寄存器
                            let mut stack_offset = 0;  // 栈上参数的偏移量
                            
                            // 1. 保存调用者保存的寄存器
                            // TODO: 在register allocation后处理
                            
                            // 2. 准备参数
                            for arg in inst.operand_iter(self.ctx) {
                                let arg_ty = arg.ty(self.ctx);
                                
                                // 获取参数值
                                let arg_reg = match &arg.try_deref(self.ctx).unwrap().kind {
                                    ir::ValueKind::Constant { value } => {
                                        match value {
                                            ir::ConstantValue::Int32 { value, .. } => {
                                                if *value == 0 {
                                                    regs::zero().into()
                                                } else {
                                                    let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                                                    curr_block.push_back(&mut self.mctx, li).unwrap();
                                                    r
                                                }
                                            }
                                            ir::ConstantValue::Float32 { value, .. } => {
                                                // 浮点常量需要先加载到通用寄存器
                                                let bits = value.to_bits();
                                                let (li, r1) = MInst::li(&mut self.mctx, bits as u64);
                                                curr_block.push_back(&mut self.mctx, li).unwrap();
                                                
                                                // 再移动到浮点寄存器
                                                let r2 = self.mctx.new_vreg(RegKind::Float).into();
                                                let mv = MInst::raw_alu_rri(
                                                    &mut self.mctx,
                                                    AluOpRRI::Addi, 
                                                    r2,
                                                    r1,
                                                    Imm12::try_from_i64(0).unwrap(),
                                                );
                                                curr_block.push_back(&mut self.mctx, mv).unwrap();
                                                r2
                                            }
                                            _ => todo!("Other constant types")
                                        }
                                    }
                                    ir::ValueKind::InstResult { .. } => {
                                        let mopd = self.lowered[&arg];
                                        match mopd.kind {
                                            MOperandKind::Reg(reg) => reg,
                                            MOperandKind::Imm(_, imm) => {
                                                let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                                                curr_block.push_back(&mut self.mctx, li).unwrap();
                                                r
                                            }
                                            MOperandKind::Mem(loc) => {
                                                // 从内存加载参数
                                                let op = if arg_ty.is_float(self.ctx) {
                                                    match arg_ty.bitwidth(self.ctx) {
                                                        32 => LoadOp::Flw,
                                                        64 => LoadOp::Fld,
                                                        _ => unreachable!()
                                                    }
                                                } else {
                                                    match arg_ty.bitwidth(self.ctx) {
                                                        8 => LoadOp::Lb,
                                                        16 => LoadOp::Lh, 
                                                        32 => LoadOp::Lw,
                                                        64 => LoadOp::Ld,
                                                        _ => unreachable!()
                                                    }
                                                };
                                                let (load, r) = MInst::load(&mut self.mctx, op, loc);
                                                curr_block.push_back(&mut self.mctx, load).unwrap();
                                                r
                                            }  
                                            MOperandKind::Undef => regs::zero().into(),
                                        }
                                    }
                                    ir::ValueKind::Param { .. } => {
                                        let mopd = self.lowered[&arg];
                                        match mopd.kind {
                                            MOperandKind::Reg(reg) => reg,
                                            MOperandKind::Mem(loc) => {
                                                let op = if arg_ty.is_float(self.ctx) {
                                                    match arg_ty.bitwidth(self.ctx) {
                                                        32 => LoadOp::Flw,
                                                        64 => LoadOp::Fld,
                                                        _ => unreachable!() 
                                                    }
                                                } else {
                                                    match arg_ty.bitwidth(self.ctx) {
                                                        8 => LoadOp::Lb,
                                                        16 => LoadOp::Lh,
                                                        32 => LoadOp::Lw,
                                                        64 => LoadOp::Ld,
                                                        _ => unreachable!()
                                                    }
                                                };
                                                let (load, r) = MInst::load(&mut self.mctx, op, loc);
                                                curr_block.push_back(&mut self.mctx, load).unwrap();
                                                r
                                            }
                                            _ => unreachable!()
                                        }
                                    }
                                };
                        
                                if arg_ty.is_float(self.ctx) {
                                    if float_reg_count < 8 {
                                        // 将参数移动到对应的浮点参数寄存器
                                        let target_reg = match float_reg_count {
                                            0 => regs::fa0(),
                                            1 => regs::fa1(),
                                            2 => regs::fa2(),
                                            3 => regs::fa3(),
                                            4 => regs::fa4(),
                                            5 => regs::fa5(),
                                            6 => regs::fa6(),
                                            7 => regs::fa7(),
                                            _ => unreachable!()
                                        };
                                        let mv = MInst::raw_alu_rri(
                                            &mut self.mctx,
                                            AluOpRRI::Addi,
                                            target_reg.into(),
                                            arg_reg,
                                            Imm12::try_from_i64(0).unwrap(),
                                        );
                                        curr_block.push_back(&mut self.mctx, mv).unwrap();
                                        float_reg_count += 1;
                                    } else {
                                        // 超出寄存器数量的参数存入栈
                                        let store_op = match arg_ty.bitwidth(self.ctx) {
                                            32 => StoreOp::Fsw,
                                            64 => StoreOp::Fsd,
                                            _ => unreachable!()
                                        };
                                        let loc = MemLoc::RegOffset {
                                            base: regs::sp().into(),
                                            offset: stack_offset,
                                        };
                                        let store = MInst::store(&mut self.mctx, store_op, arg_reg, loc);
                                        curr_block.push_back(&mut self.mctx, store).unwrap();
                                        stack_offset += 8;
                                    }
                                } else {
                                    if int_reg_count < 8 {
                                        // 将参数移动到对应的整数参数寄存器
                                        let target_reg = match int_reg_count {
                                            0 => regs::a0(),
                                            1 => regs::a1(),
                                            2 => regs::a2(),
                                            3 => regs::a3(),
                                            4 => regs::a4(),
                                            5 => regs::a5(),
                                            6 => regs::a6(),
                                            7 => regs::a7(),
                                            _ => unreachable!()
                                        };
                                        let mv = MInst::raw_alu_rri(
                                            &mut self.mctx,
                                            AluOpRRI::Addi,
                                            target_reg.into(),
                                            arg_reg,
                                            Imm12::try_from_i64(0).unwrap(),
                                        );
                                        curr_block.push_back(&mut self.mctx, mv).unwrap();
                                        int_reg_count += 1;
                                    } else {
                                        // 超出寄存器数量的参数存入栈
                                        let store_op = match arg_ty.bitwidth(self.ctx) {
                                            8 => StoreOp::Sb,
                                            16 => StoreOp::Sh,
                                            32 => StoreOp::Sw,
                                            64 => StoreOp::Sd,
                                            _ => unreachable!()
                                        };
                                        let loc = MemLoc::RegOffset {
                                            base: regs::sp().into(),
                                            offset: stack_offset,
                                        };
                                        let store = MInst::store(&mut self.mctx, store_op, arg_reg, loc);
                                        curr_block.push_back(&mut self.mctx, store).unwrap();
                                        stack_offset += 8;
                                    }
                                }
                            }
                        
                            // 更新函数的outgoing stack size
                            if stack_offset > 0 {
                                curr_func.update_outgoing_stack_size(&mut self.mctx, stack_offset as u64);
                            }
                        
                            // 3. 生成call指令
                            let call = MInst::call(&mut self.mctx, callee);
                            curr_block.push_back(&mut self.mctx, call).unwrap();
                        
                            // 4. 处理返回值
                            if let Some(result) = inst.result(self.ctx) {
                                let result_ty = result.ty(self.ctx);
                                let rd = self.mctx.new_vreg(
                                    if result_ty.is_float(self.ctx) {
                                        RegKind::Float
                                    } else {
                                        RegKind::General
                                    }
                                ).into();
                        
                                // 从返回值寄存器移动到新的虚拟寄存器
                                let src_reg = if result_ty.is_float(self.ctx) {
                                    regs::fa0().into()
                                } else {
                                    regs::a0().into()
                                };
                                
                                let mv = MInst::raw_alu_rri(
                                    &mut self.mctx,
                                    AluOpRRI::Addi,
                                    rd,
                                    src_reg,
                                    Imm12::try_from_i64(0).unwrap(),
                                );
                                curr_block.push_back(&mut self.mctx, mv).unwrap();
                        
                                // 保存返回值的映射
                                let mopd = MOperand {
                                    ty: result_ty,
                                    kind: MOperandKind::Reg(rd),
                                };
                                self.lowered.insert(result, mopd);
                            }
                        }
                        ir::InstKind::GetElementPtr { bound_ty } => {
                            todo!()
                        }
                        ir::InstKind::Phi => {
                            let curr_block = self.curr_block.unwrap();
                            let result_ty = inst.result(self.ctx).unwrap().ty(self.ctx);
                            
                            // 为phi指令的结果分配一个虚拟寄存器
                            let phi_reg = self.mctx.new_vreg(
                                if result_ty.is_float(self.ctx) {
                                    RegKind::Float
                                } else {
                                    RegKind::General
                                }
                            ).into();
                        
                            // 创建结果操作数
                            let result_opd = MOperand {
                                ty: result_ty,
                                kind: MOperandKind::Reg(phi_reg),
                            };
                            self.lowered.insert(inst.result(self.ctx).unwrap(), result_opd);
                        
                            // 获取phi节点信息
                            let phi_data = inst.try_deref(self.ctx).unwrap();
                            for (i, (pred_bb, _)) in phi_data.phi_node.iter().enumerate() {
                                let pred_mblock = self.blocks[pred_bb];
                                // 获取对应的值操作数
                                let value = inst.operand(self.ctx, i);
                        
                                // 获取该前驱传来的值
                                let src_reg = match &value.try_deref(self.ctx).unwrap().kind {
                                    ir::ValueKind::Constant { value } => {
                                        match value {
                                            ir::ConstantValue::Int32 { value, .. } => {
                                                if *value == 0 {
                                                    regs::zero().into()
                                                } else {
                                                    let (li, r) = MInst::li(&mut self.mctx, (*value) as u64);
                                                    pred_mblock.push_back(&mut self.mctx, li).unwrap();
                                                    r
                                                }
                                            }
                                            ir::ConstantValue::Float32 { value, .. } => {
                                                // 浮点常量需要先加载到通用寄存器
                                                let bits = value.to_bits();
                                                let (li, r1) = MInst::li(&mut self.mctx, bits as u64);
                                                pred_mblock.push_back(&mut self.mctx, li).unwrap();
                        
                                                // 再移动到浮点寄存器
                                                let r2 = self.mctx.new_vreg(RegKind::Float).into();
                                                let mv = MInst::raw_alu_rri(
                                                    &mut self.mctx,
                                                    AluOpRRI::Addi,
                                                    r2,
                                                    r1,
                                                    Imm12::try_from_i64(0).unwrap(),
                                                );
                                                pred_mblock.push_back(&mut self.mctx, mv).unwrap();
                                                r2
                                            }
                                            ir::ConstantValue::Undef { .. } => {
                                                regs::zero().into()
                                            }
                                            ir::ConstantValue::Int1 { value, .. } => {
                                                let imm = if *value { 1 } else { 0 };
                                                let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                                                pred_mblock.push_back(&mut self.mctx, li).unwrap();
                                                r
                                            }
                                            _ => unreachable!("Unsupported constant type in phi"),
                                        }
                                    }
                                    ir::ValueKind::InstResult { .. } => {
                                        let mopd = match self.lowered.get(&value) {
                                            Some(mopd) => mopd,
                                            None => {
                                                // 给出默认值或错误处理
                                                println!("Warning: No lowered operand found for value {:?}", value);
                                                continue;
                                                // 或返回一个默认操作数
                                                // return MOperand { ... };
                                            }
                                        };
                                        match mopd.kind {
                                            MOperandKind::Reg(reg) => reg,
                                            MOperandKind::Imm(_, imm) => {
                                                let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                                                pred_mblock.push_back(&mut self.mctx, li).unwrap();
                                                r
                                            }
                                            MOperandKind::Mem(loc) => {
                                                // 从内存加载值
                                                let op = if result_ty.is_float(self.ctx) {
                                                    match result_ty.bitwidth(self.ctx) {
                                                        32 => LoadOp::Flw,
                                                        64 => LoadOp::Fld,
                                                        _ => unreachable!(),
                                                    }
                                                } else {
                                                    match result_ty.bitwidth(self.ctx) {
                                                        8 => LoadOp::Lb,
                                                        16 => LoadOp::Lh,
                                                        32 => LoadOp::Lw,
                                                        64 => LoadOp::Ld,
                                                        _ => unreachable!(),
                                                    }
                                                };
                                                let (load, r) = MInst::load(&mut self.mctx, op, loc);
                                                pred_mblock.push_back(&mut self.mctx, load).unwrap();
                                                r
                                            }
                                            MOperandKind::Undef => regs::zero().into(),
                                        }
                                    }
                                    ir::ValueKind::Param { .. } => {
                                        let mopd = self.lowered[&value];
                                        match mopd.kind {
                                            MOperandKind::Reg(reg) => reg,
                                            MOperandKind::Mem(loc) => {
                                                let op = if result_ty.is_float(self.ctx) {
                                                    match result_ty.bitwidth(self.ctx) {
                                                        32 => LoadOp::Flw,
                                                        64 => LoadOp::Fld,
                                                        _ => unreachable!(),
                                                    }
                                                } else {
                                                    match result_ty.bitwidth(self.ctx) {
                                                        8 => LoadOp::Lb,
                                                        16 => LoadOp::Lh,
                                                        32 => LoadOp::Lw,
                                                        64 => LoadOp::Ld,
                                                        _ => unreachable!(),
                                                    }
                                                };
                                                let (load, r) = MInst::load(&mut self.mctx, op, loc);
                                                pred_mblock.push_back(&mut self.mctx, load).unwrap();
                                                r
                                            }
                                            _ => unreachable!("Invalid parameter kind"),
                                        }
                                    }
                                };
                        
                                // 在前驱块末尾生成移动指令
                                // 这里需要小心处理分支指令，移动指令应该在分支指令之前
                                let mut curr_inst = pred_mblock.tail(&self.mctx);
                                while let Some(inst) = curr_inst {
                                    match inst.kind(&self.mctx) {
                                        MInstKind::J { .. } | MInstKind::Br { .. } => {
                                            // 找到了分支指令，在它之前插入移动指令
                                            let mv = MInst::raw_alu_rri(
                                                &mut self.mctx,
                                                AluOpRRI::Addi,
                                                phi_reg,
                                                src_reg,
                                                Imm12::try_from_i64(0).unwrap(),
                                            );
                                            
                                            // 找到分支指令的前一条指令
                                            if let Some(prev_inst) = inst.prev(&self.mctx) {
                                                // 在前一条指令之后插入移动指令
                                                mv.set_prev(&mut self.mctx, Some(prev_inst));
                                                mv.set_next(&mut self.mctx, Some(inst));
                                                prev_inst.set_next(&mut self.mctx, Some(mv));
                                                inst.set_prev(&mut self.mctx, Some(mv));
                                            } else {
                                                // 分支指令是块的第一条指令
                                                mv.set_next(&mut self.mctx, Some(inst));
                                                inst.set_prev(&mut self.mctx, Some(mv));
                                                pred_mblock.set_head(&mut self.mctx, Some(mv));
                                            }
                                            break;
                                        }
                                        _ => {
                                            curr_inst = inst.prev(&self.mctx);
                                        }
                                    }
                                }
                        
                                // 如果没找到分支指令，就在块末尾添加移动指令
                                if curr_inst.is_none() {
                                    let mv = MInst::raw_alu_rri(
                                        &mut self.mctx,
                                        AluOpRRI::Addi,
                                        phi_reg,
                                        src_reg,
                                        Imm12::try_from_i64(0).unwrap(),
                                    );
                                    pred_mblock.push_back(&mut self.mctx, mv).unwrap();
                                }
                            }
                        }
                        // TODO: Add more instuctions.
                    }
                }
            }
        }
    }

    fn gen_move(&mut self, dst: Reg, src: Reg, ty: Ty) {
        let curr_block = self.curr_block.unwrap();

        if ty.is_float(self.ctx) {
            // 浮点寄存器移动 
            todo!()
        } else {
            // 整数或指针类型的移动
            let mv = MInst::raw_alu_rri(
                &mut self.mctx,
                AluOpRRI::Addi,
                dst,
                src, 
                Imm12::try_from_i64(0).unwrap(),
            );
            curr_block.push_back(&mut self.mctx, mv).unwrap();
        }
    }

    /// 处理入口块的参数
    fn gen_incoming(&mut self, func: ir::Func) {
        let mut used_int_regs = 0;
        let mut used_fp_regs = 0;
        let mut stack_offset = 16; // XXX: ?

        // 处理函数参数
        for param in func.params(self.ctx) {
            let ty = param.ty(self.ctx);
            if ty.is_float(self.ctx) {
                if used_fp_regs < 8 {
                    // 使用浮点参数寄存器
                    let preg = match used_fp_regs {
                        0 => regs::fa0(),
                        1 => regs::fa1(),
                        2 => regs::fa2(), 
                        3 => regs::fa3(),
                        4 => regs::fa4(),
                        5 => regs::fa5(),
                        6 => regs::fa6(),
                        7 => regs::fa7(),
                        _ => unreachable!(),
                    };

                    let vreg = self.mctx.new_vreg(RegKind::Float);
                    let mopd = MOperand {
                        ty,
                        kind: MOperandKind::Reg(vreg.into()),
                    };
                    self.lowered.insert(*param, mopd);

                    // 生成移动指令
                    self.gen_move(vreg.into(), preg.into(), ty);
                    used_fp_regs += 1;
                } else {
                    // 从栈上加载
                    let mem_loc = MemLoc::Incoming { offset: stack_offset };
                    let mopd = self.gen_load(ty, mem_loc);
                    self.lowered.insert(*param, mopd);
                    stack_offset += 8;
                }
            } else {
                // 整数或指针类型
                if used_int_regs < 8 {
                    let preg = match used_int_regs {
                        0 => regs::a0(),
                        1 => regs::a1(),
                        2 => regs::a2(),
                        3 => regs::a3(),
                        4 => regs::a4(),
                        5 => regs::a5(),
                        6 => regs::a6(),
                        7 => regs::a7(),
                        _ => unreachable!(),
                    };

                    let vreg = self.mctx.new_vreg(RegKind::General); 
                    let mopd = MOperand {
                        ty,
                        kind: MOperandKind::Reg(vreg.into()),
                    };
                    self.lowered.insert(*param, mopd);

                    // 生成移动指令
                    self.gen_move(vreg.into(), preg.into(), ty);
                    used_int_regs += 1; 
                } else {
                    // 从栈上加载
                    let mem_loc = MemLoc::Incoming { offset: stack_offset };
                    let mopd = self.gen_load(ty, mem_loc);
                    self.lowered.insert(*param, mopd);
                    stack_offset += 8; // XXX: ?
                }
            }
        }
    }

    /// Do the code generation after register allocation.
    pub fn after_regalloc(&mut self) {
        // TODO: The stack frame is determined after register allocation, so
        // we need to add instructions to adjust the stack frame.
        //
        // There should be two stages:
        //  1. Prologue: Save the callee-saved registers and adjust the stack frame.
        //  2. Epilogue: Restore the callee-saved registers and handle return.
        //
        // Depending on your implementation, you may need to adjust stack slots
        // offsets after these two stages.
        // todo!("after register allocation");

        for func in self.ctx.funcs(){
            self.curr_func = Some(self.funcs[func.name(self.ctx)]);
            let mfunc = self.curr_func.unwrap();

            if mfunc.is_external(&self.mctx){
                continue;
            }

            self.curr_block = Some(mfunc.head(&self.mctx).unwrap());
            println!("Generating func prologue for function {}", func.name(self.ctx));
            self.gen_func_prologue(mfunc);

            self.curr_block = Some(mfunc.tail(&self.mctx).unwrap());
            println!("Generating func epilogue for function {}", func.name(self.ctx));
            self.gen_func_epilogue(mfunc);
            // println!("Generating code for function {}", func.name(self.ctx));
        }

        // prologue/epilogue might changed the saved regs or other things, so we
        // postpone the offset adjustment to here
        self.adjust_offset();
    }

    pub fn gen_func_prologue(&mut self, func: MFunc) {
        let curr_block = self.curr_block.unwrap();
        // println!("Generating prologue for function {:#?}", curr_block);

        // 不管要不要保存这些寄存器，都先保存着
        func.add_saved_reg(&mut self.mctx, regs::ra());
        func.add_saved_reg(&mut self.mctx, regs::s0());
        let saved_regs = func.saved_regs(&self.mctx);
        println!("Saved regs: {:?}", saved_regs);
        let total_stack_size = self.total_stack_size(func) as i64;
        println!("Total stack size: {}", total_stack_size);

        
        let mut inst_buf: Vec<MInst> = Vec::new();

        let sp: PReg = regs::sp().into();
        let fp: PReg = regs::fp().into();

        if let Some(imm) = Imm12::try_from_i64(-total_stack_size) {
            let addi = MInst::raw_alu_rri(
                &mut self.mctx, 
                AluOpRRI::Addi, 
                sp.into(), 
                sp.into(), 
                imm
            );
            // println!("Addi: {}", addi.display(self.mctx()));
            inst_buf.push(addi);
        } else {    
            let t0 = regs::t0();
            let li = MInst::build_li(&mut self.mctx, t0.into(), total_stack_size as u64);
            let sub = MInst::build_alu_rrr(
                &mut self.mctx,
                AluOpRRR::Sub,
                sp.into(),
                sp.into(),
                t0.into(),
            );
            inst_buf.push(li);
            inst_buf.push(sub);
        }

        // 保存调用者保存的寄存器
        let mut curr_offset = total_stack_size -8;
        for reg in saved_regs {
            if let RegKind::General = reg.kind() {
                if let Some(imm) = Imm12::try_from_i64(curr_offset) {
                    let store = MInst::store(
                        &mut self.mctx, 
                        StoreOp::Sd, 
                        reg.into(), 
                        MemLoc::RegOffset{
                            base: sp.into(), 
                            offset: imm.as_i16() as i64
                        }
                    );
                    // println!("Store: {}", store.display(self.mctx()));
                    inst_buf.push(store);
                } else {
                    let t0 = regs::t0();
                    let li = MInst::build_li(&mut self.mctx, t0.into(), curr_offset as u64);
                    let add = MInst::build_alu_rrr(&mut self.mctx, AluOpRRR::Add, t0.into(), sp.into(), t0.into());
                    let store = MInst::store(
                        &mut self.mctx, 
                        StoreOp::Sw, 
                        reg.into(), 
                        MemLoc::RegOffset { 
                            base: t0.into(), 
                            offset: 0 
                        }
                    );
                    inst_buf.push(li);
                    inst_buf.push(add);
                    inst_buf.push(store);
                }
            } else if let RegKind::Float = reg.kind() {
                unimplemented!("Float register saving is not implemented yet");
            } else {
                unimplemented!("Saving register of kind {:?} is not implemented yet", reg.kind());
            }
            curr_offset -= 8;
        }

        for inst in inst_buf.into_iter().rev() {
            // println!("Pushing inst: {}", inst.display(self.mctx()));
            curr_block.push_front(&mut self.mctx, inst).unwrap();
        }
    }

    pub fn gen_func_epilogue(&mut self, func: MFunc) {
        let curr_block = self.curr_block.unwrap();
        let saved_regs = func.saved_regs(&self.mctx);

        let total_stack_size = self.total_stack_size(func) as i64;

        let mut inst_buf: Vec<MInst> = Vec::new();

        let sp:PReg = regs::sp().into();

        let mut curr_offset = total_stack_size - 8;

        for reg in saved_regs {
            if let RegKind::General = reg.kind() {
                if let Some(imm) = Imm12::try_from_i64(curr_offset) {
                    let load = MInst::build_load(
                        &mut self.mctx, 
                        LoadOp::Ld, 
                        reg.into(), 
                    MemLoc::RegOffset {
                            base: sp.into(), 
                            offset: imm.as_i16() as i64
                        }
                    );
                    inst_buf.push(load);
                } else {
                    let t0 = regs::t0();
                    let li = MInst::build_li(&mut self.mctx, t0.into(), curr_offset as u64);
                    let add = MInst::build_alu_rrr(&mut self.mctx, AluOpRRR::Add, t0.into(), sp.into(), t0.into());
                    let load = MInst::build_load(
                        &mut self.mctx, 
                        LoadOp::Lw, 
                        reg.into(), 
                        MemLoc::RegOffset { 
                            base: t0.into(), 
                            offset: 0 
                        }
                    );
                    inst_buf.push(li);
                    inst_buf.push(add);
                    inst_buf.push(load);
                }
            } else if let RegKind::Float = reg.kind() {
                unimplemented!("Float register saving is not implemented yet");
            } else {
                unimplemented!("Saving register of kind {:?} is not implemented yet", reg.kind());
            }
            curr_offset -= 8;
        }

        if let Some(imm) = Imm12::try_from_i64(total_stack_size) {
            let addi = MInst::raw_alu_rri(
                &mut self.mctx, 
                AluOpRRI::Addi, 
                sp.into(), 
                sp.into(), 
                imm
            );
            inst_buf.push(addi);
        } else {    
            let t0 = regs::t0();
            let li = MInst::build_li(&mut self.mctx, t0.into(), total_stack_size as u64);
            let add = MInst::build_alu_rrr(
                &mut self.mctx,
                AluOpRRR::Add,
                sp.into(),
                sp.into(),
                t0.into(),
            );
            inst_buf.push(li);
            inst_buf.push(add);
        }

        for inst in inst_buf.into_iter() {
            curr_block.push_back(&mut self.mctx, inst).unwrap();
        }

        self.gen_ret();
    }

    fn gen_ret(&mut self) {
        let curr_block = self.curr_block.unwrap();
        let inst = MInst::ret(&mut self.mctx);
        curr_block.push_back(&mut self.mctx, inst).unwrap();
    }
    
    fn total_stack_size(&mut self, mfunc: MFunc) -> u64 {
        let saved_regs = mfunc.saved_regs(&self.mctx);
        println!("Saved regs size {:?}", saved_regs.len() as u64 * 8);
        let raw = mfunc.storage_stack_size(&self.mctx)
            + mfunc.outgoing_stack_size(&self.mctx)
            + saved_regs.len() as u64 * 8;
        (raw + 15) & !15
    }

    pub fn adjust_offset(&mut self) {
        for func in self.ctx.funcs() {
            let mfunc = self.funcs[func.name(self.ctx)];
        
            if mfunc.is_external(&self.mctx) {
                continue;
            }

            println!("Function: {}", func.name(self.ctx));

            let storage_size = mfunc.storage_stack_size(&self.mctx) as i64;
            println!("Storage size: {}", storage_size);
            let outgoing_size = mfunc.outgoing_stack_size(&self.mctx) as i64;
            println!("Outgoing size: {}", outgoing_size);

            let total_stack_size = self.total_stack_size(mfunc) as i64;
            println!("Total stack size: {}", total_stack_size);

            let mut curr_block = mfunc.head(&self.mctx);

            while let Some(block) = curr_block {
                let mut curr_inst = block.head(&self.mctx);
                while let Some(inst) = curr_inst {
                    inst.adjust_offset(
                        &mut self.mctx,
                        |mem_loc| match mem_loc {
                            MemLoc::Slot { offset } => Some(MemLoc::RegOffset {
                                base: regs::sp().into(),
                                offset: storage_size + outgoing_size + offset,
                            }),
                            MemLoc::Incoming { offset } => Some(MemLoc::RegOffset {
                                base: regs::sp().into(),
                                offset: total_stack_size + offset,
                            }),
                            MemLoc::RegOffset { .. } => None,
                        },
                    );
                    curr_inst = inst.next(&self.mctx);
                }
                curr_block = block.next(&self.mctx);
            }
        }
    }

    /// Emit the assembly code.
    ///
    /// It's not necessary to implement this function, you can also handle the
    /// emission directly in `main.rs`.
    pub fn emit(&mut self) {
        // TODO: Emit the assembly code.
    }

    /// Generate a store instruction and append it to the current block.
    /// Here we just demonstrate the idea. Bugs may exist. You can
    /// refactor this entirely as your own way.
    pub fn gen_store(&mut self, val: Value, mem_loc: MemLoc) {
        let curr_block = self.curr_block.unwrap();
    
        let src = match &val.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { value } => {
                match value {
                    ir::ConstantValue::Int32 { value, .. } => {
                        if value == &0 {
                            regs::zero().into()
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            r
                        }
                    }
                    ir::ConstantValue::Float32 { value, .. } => {
                        let bits = value.to_bits();
                        // 先加载到通用寄存器
                        let (li, r1) = MInst::li(&mut self.mctx, bits as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        // 转移到浮点寄存器
                        let r2 = self.mctx.new_vreg(RegKind::Float).into();
                        let mv = MInst::raw_alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Addi,
                            r2,
                            r1,
                            Imm12::try_from_i64(0).unwrap(),
                        );
                        curr_block.push_back(&mut self.mctx, mv).unwrap();
                        r2
                    }
                    ir::ConstantValue::Undef { .. } => {
                        regs::zero().into()
                    }
                    // 处理其他常量类型
                    _ => todo!("Unsupported constant type for store"),
                }
            }
            ir::ValueKind::InstResult { .. } => {
                let mopd = self.lowered[&val];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Imm(_, imm) => {
                        // 如果是立即数,需要先加载到寄存器
                        let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    MOperandKind::Mem(loc) => {
                        // 如果是内存地址,需要先加载到寄存器
                        let bitwidth = val.ty(self.ctx).bitwidth(self.ctx);
                        let op = match bitwidth {
                            8 => LoadOp::Lb,
                            16 => LoadOp::Lh,
                            32 => LoadOp::Lw,
                            64 => LoadOp::Ld,
                            _ => unreachable!(),
                        };
                        let (load, r) = MInst::load(&mut self.mctx, op, loc);
                        curr_block.push_back(&mut self.mctx, load).unwrap();
                        r
                    }
                    MOperandKind::Undef => todo!("Store from undef"),
                }
            }
            ir::ValueKind::Param { .. } => {
                // 参数应该已经在 gen_incoming 中处理并存储在 lowered 中
                let mopd = self.lowered[&val];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Mem(loc) => {
                        // 如果参数在栈上,需要先加载到寄存器
                        let bitwidth = val.ty(self.ctx).bitwidth(self.ctx);
                        let op = match bitwidth {
                            8 => LoadOp::Lb,
                            16 => LoadOp::Lh,
                            32 => LoadOp::Lw,
                            64 => LoadOp::Ld,
                            _ => unreachable!(),
                        };
                        let (load, r) = MInst::load(&mut self.mctx, op, loc);
                        curr_block.push_back(&mut self.mctx, load).unwrap();
                        r
                    }
                    _ => unreachable!("Invalid parameter kind"),
                }
            }
        };
    
        let ty = val.ty(self.ctx);
        let op = if ty.is_float(self.ctx) {
            match ty.bitwidth(self.ctx) {
                32 => StoreOp::Fsw,
                64 => StoreOp::Fsd,
                _ => unreachable!("Invalid float type width"),
            }
        } else {
            match ty.bitwidth(self.ctx) {
                1 | 8 => StoreOp::Sb,
                16 => StoreOp::Sh,
                32 => StoreOp::Sw,
                64 => StoreOp::Sd,
                _ => unreachable!("Invalid integer type width"),
            }
        };
    
        let store = MInst::store(&mut self.mctx, op, src, mem_loc);
        curr_block.push_back(&mut self.mctx, store).unwrap();
    }

    /// Generate a load instruction and append it to the current block.
    /// /// Here we just demonstrate the idea. Bugs may exist. You can
    /// refactor this entirely as your own way.
    pub fn gen_load(&mut self, ty: Ty, mem_loc: MemLoc) -> MOperand {
        let curr_block = self.curr_block.unwrap();
    
        if ty.is_float(self.ctx) {
            let op = match ty.bitwidth(self.ctx) {
                32 => LoadOp::Flw,
                64 => LoadOp::Fld,
                _ => unreachable!("Invalid float type width"),
            };
            todo!("Float load")
        } else {
            let op = match ty.bitwidth(self.ctx) {
                1 | 8 => LoadOp::Lb,
                16 => LoadOp::Lh,
                32 => LoadOp::Lw,
                64 => LoadOp::Ld,
                _ => unreachable!("Invalid integer type width"),
            };
            let (load, rd) = MInst::load(&mut self.mctx, op, mem_loc);
            curr_block.push_back(&mut self.mctx, load).unwrap();
            // println!("Load: {:?}", rd);
            MOperand {
                ty,
                kind: MOperandKind::Reg(rd),
            }
        }
    }

    /// Generate an integer binary operation and append it to the current block.
    /// Here we just demonstrate the idea. Bugs may exist. You can
    /// refactor this entirely as your own way.
    pub fn gen_int_binary(&mut self, op: IntBinaryOp, lhs: Value, rhs: Value) -> MOperand {
        let curr_block = self.curr_block.unwrap();

        // TODO: We only handle reg + reg here, you need to handle other cases.
        let (lhs_kind, rhs_kind) = self.get_operand_kinds(lhs, rhs);
        let lhs_ty = lhs.ty(self.ctx);
        let bitwidth = lhs.ty(self.ctx).bitwidth(self.ctx);

        let make_result = |reg: Reg| MOperand {
            ty: lhs_ty,
            kind: MOperandKind::Reg(reg)
        };


        match op {
            IntBinaryOp::Add => {
                let addi_op = match bitwidth {
                    32 => AluOpRRI::Addiw,
                    64 => AluOpRRI::Addi,
                    _ => unreachable!("invalid int width"),
                };

                let add_op = match bitwidth {
                    32 => AluOpRRR::Addw,
                    64 => AluOpRRR::Add,
                    _ => unreachable!("invalid int width"),
                };

                match (&lhs_kind, &rhs_kind) {
                    (MOperandKind::Reg(lhs_reg), MOperandKind::Reg(rhs_reg)) => {
                        // Register + Register
                        let (add, rd) = MInst::alu_rrr(&mut self.mctx, add_op, *lhs_reg, *rhs_reg);
                        curr_block.push_back(&mut self.mctx, add).unwrap();
                        make_result(rd)
                    }
                    (MOperandKind::Reg(reg), MOperandKind::Imm(_, imm)) |
                    (MOperandKind::Imm(_, imm), MOperandKind::Reg(reg)) => {
                        // Register + Immediate
                        if let Some(imm12) = Imm12::try_from_i64(*imm) {
                            let (add, rd) = MInst::alu_rri(&mut self.mctx, addi_op, *reg, imm12);
                            curr_block.push_back(&mut self.mctx, add).unwrap();
                            make_result(rd)
                        } else {
                            // // Immediate too large, load it into register first
                            // let (li, r) = MInst::li(&mut self.mctx, *imm as u64); 
                            // curr_block.push_back(&mut self.mctx, li).unwrap();
                            // let (add, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *reg, r);
                            // curr_block.push_back(&mut self.mctx, add).unwrap();
                            // make_result(rd)
                            todo!()
                        }
                    }
                    (MOperandKind::Imm(_, imm1), MOperandKind::Imm(_, imm2)) => {
                        // Immediate + Immediate
                        let (li, r) = MInst::li(&mut self.mctx, *imm1 as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        let (add, rd) = MInst::alu_rri(&mut self.mctx, addi_op, r, Imm12::try_from_i64(*imm2).unwrap());
                        curr_block.push_back(&mut self.mctx, add).unwrap();
                        make_result(rd)
                    }
                    _ => {
                        println!("lhs_kind: {:?}, rhs_kind: {:?}", lhs_kind, rhs_kind);
                        unreachable!("Invalid operand combination");
                    },
                }
            }
            IntBinaryOp::Sub => {
                let subi_op = match bitwidth {
                    32 => AluOpRRI::Addiw,
                    64 => AluOpRRI::Addi,
                    _ => unreachable!("invalid int width"),
                };

                let sub_op = match bitwidth {
                    32 => AluOpRRR::Subw,
                    64 => AluOpRRR::Sub,
                    _ => unreachable!("invalid int width"),
                };

                match (&lhs_kind, &rhs_kind) {
                    (MOperandKind::Reg(lhs_reg), MOperandKind::Reg(rhs_reg)) => {
                        let (sub, rd) = MInst::alu_rrr(&mut self.mctx, sub_op, *lhs_reg, *rhs_reg);
                        curr_block.push_back(&mut self.mctx, sub).unwrap();
                        make_result(rd)
                    }
                    (MOperandKind::Reg(reg), MOperandKind::Imm(_, imm)) => {
                        // Convert subtraction of immediate to addition of negative immediate
                        if let Some(imm12) = Imm12::try_from_i64(-*imm) {
                            let (add, rd) = MInst::alu_rri(&mut self.mctx, subi_op, *reg, imm12);
                            curr_block.push_back(&mut self.mctx, add).unwrap();
                            make_result(rd)
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            let alu_op = match bitwidth {
                                32 => AluOpRRR::Subw,
                                64 => AluOpRRR::Sub,
                                _ => unreachable!("invalid int width"),
                            };
                            let (sub, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *reg, r);
                            curr_block.push_back(&mut self.mctx, sub).unwrap();
                            make_result(rd)
                        }
                    }
                    (MOperandKind::Imm(_, imm), MOperandKind::Reg(reg)) => {
                        // Convert subtraction of immediate to addition of negative immediate
                        if let Some(imm12) = Imm12::try_from_i64(-*imm) {
                            let (add, rd) = MInst::alu_rri(&mut self.mctx, subi_op, *reg, imm12);
                            curr_block.push_back(&mut self.mctx, add).unwrap();
                            make_result(rd)
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            let alu_op = match bitwidth {
                                32 => AluOpRRR::Subw,
                                64 => AluOpRRR::Sub,
                                _ => unreachable!("invalid int width"),
                            };
                            let (sub, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *reg, r);
                            curr_block.push_back(&mut self.mctx, sub).unwrap();
                            make_result(rd)
                        }
                    }
                    (MOperandKind::Imm(_, imm1), MOperandKind::Imm(_, imm2)) => {
                        let (li, r) = MInst::li(&mut self.mctx, *imm1 as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        let (add, rd) = MInst::alu_rri(&mut self.mctx, subi_op, r, Imm12::try_from_i64(-*imm2).unwrap());
                        curr_block.push_back(&mut self.mctx, add).unwrap();
                        make_result(rd)
                    }
                    _ => unreachable!("invalid operand combination"),
                }
            }
            IntBinaryOp::Mul => {
                // Multiplication only has register-register form
                let (lhs_reg, rhs_reg) = self.get_regs_for_op(lhs_kind, rhs_kind, curr_block);
                let alu_op = match bitwidth {
                    32 => AluOpRRR::Mulw,
                    64 => AluOpRRR::Mul,
                    _ => unreachable!("invalid int width"),
                };
                let (mul, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, lhs_reg, rhs_reg);
                curr_block.push_back(&mut self.mctx, mul).unwrap();
                make_result(rd)
            }
            IntBinaryOp::SDiv => {
                let (lhs_reg, rhs_reg) = self.get_regs_for_op(lhs_kind, rhs_kind, curr_block);
                let alu_op = match bitwidth {
                    32 => AluOpRRR::Divw,
                    64 => AluOpRRR::Div,
                    _ => unreachable!("invalid int width"),
                };
                let (div, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, lhs_reg, rhs_reg);
                curr_block.push_back(&mut self.mctx, div).unwrap();
                make_result(rd)
            }
            IntBinaryOp::UDiv => {
                let (lhs_reg, rhs_reg) = self.get_regs_for_op(lhs_kind, rhs_kind, curr_block);
                let alu_op = match bitwidth {
                    32 => AluOpRRR::Divuw,
                    64 => AluOpRRR::Divu,
                    _ => unreachable!("invalid int width"),
                };
                let (div, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, lhs_reg, rhs_reg);
                curr_block.push_back(&mut self.mctx, div).unwrap();
                make_result(rd)
            }
            IntBinaryOp::SRem => {
                let (lhs_reg, rhs_reg) = self.get_regs_for_op(lhs_kind, rhs_kind, curr_block);
                let alu_op = match bitwidth {
                    32 => AluOpRRR::Remw,
                    64 => AluOpRRR::Rem,
                    _ => unreachable!("invalid int width"), 
                };
                let (rem, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, lhs_reg, rhs_reg);
                curr_block.push_back(&mut self.mctx, rem).unwrap();
                make_result(rd)
            }
            IntBinaryOp::URem => {
                let (lhs_reg, rhs_reg) = self.get_regs_for_op(lhs_kind, rhs_kind, curr_block);
                let alu_op = match bitwidth {
                    32 => AluOpRRR::Remuw,
                    64 => AluOpRRR::Remu,
                    _ => unreachable!("invalid int width"),
                };
                let (rem, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, lhs_reg, rhs_reg);
                curr_block.push_back(&mut self.mctx, rem).unwrap();
                make_result(rd)
            }
            IntBinaryOp::Shl => {
                match (&lhs_kind, &rhs_kind) {
                    (MOperandKind::Reg(lhs_reg), MOperandKind::Reg(rhs_reg)) => {
                        let alu_op = match bitwidth {
                            32 => AluOpRRR::Sllw,
                            64 => AluOpRRR::Sll,
                            _ => unreachable!("invalid int width"),
                        };
                        let (shl, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *lhs_reg, *rhs_reg);
                        curr_block.push_back(&mut self.mctx, shl).unwrap();
                        make_result(rd)
                    }
                    (MOperandKind::Reg(reg), MOperandKind::Imm(_, imm)) => {
                        if let Some(imm12) = Imm12::try_from_i64(*imm) {
                            let alu_op = match bitwidth {
                                32 => AluOpRRI::Slliw,
                                64 => AluOpRRI::Slli,
                                _ => unreachable!("invalid int width"),
                            };
                            let (shl, rd) = MInst::alu_rri(&mut self.mctx, alu_op, *reg, imm12);
                            curr_block.push_back(&mut self.mctx, shl).unwrap();
                            make_result(rd)
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            let alu_op = match bitwidth {
                                32 => AluOpRRR::Sllw,
                                64 => AluOpRRR::Sll,
                                _ => unreachable!("invalid int width"),
                            };
                            let (shl, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *reg, r);
                            curr_block.push_back(&mut self.mctx, shl).unwrap();
                            make_result(rd)
                        }
                    }
                    _ => unreachable!("invalid operand combination"),
                }
            }
            IntBinaryOp::LShr => {
                match (&lhs_kind, &rhs_kind) {
                    (MOperandKind::Reg(lhs_reg), MOperandKind::Reg(rhs_reg)) => {
                        let alu_op = match bitwidth {
                            32 => AluOpRRR::Srlw,
                            64 => AluOpRRR::Srl,
                            _ => unreachable!("invalid int width"),
                        };
                        let (shr, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *lhs_reg, *rhs_reg);
                        curr_block.push_back(&mut self.mctx, shr).unwrap();
                        make_result(rd)
                    }
                    (MOperandKind::Reg(reg), MOperandKind::Imm(_, imm)) => {
                        if let Some(imm12) = Imm12::try_from_i64(*imm) {
                            let alu_op = match bitwidth {
                                32 => AluOpRRI::Srliw,
                                64 => AluOpRRI::Srli,
                                _ => unreachable!("invalid int width"),
                            };
                            let (shr, rd) = MInst::alu_rri(&mut self.mctx, alu_op, *reg, imm12);
                            curr_block.push_back(&mut self.mctx, shr).unwrap();
                            make_result(rd)
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            let alu_op = match bitwidth {
                                32 => AluOpRRR::Srlw,
                                64 => AluOpRRR::Srl,
                                _ => unreachable!("invalid int width"),
                            };
                            let (shr, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *reg, r);
                            curr_block.push_back(&mut self.mctx, shr).unwrap();
                            make_result(rd)
                        }
                    }
                    _ => unreachable!("invalid operand combination"),
                }
            }
            IntBinaryOp::AShr => {
                match (&lhs_kind, &rhs_kind) {
                    (MOperandKind::Reg(lhs_reg), MOperandKind::Reg(rhs_reg)) => {
                        let alu_op = match bitwidth {
                            32 => AluOpRRR::Sraw,
                            64 => AluOpRRR::Sra,
                            _ => unreachable!("invalid int width"),
                        };
                        let (shr, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *lhs_reg, *rhs_reg);
                        curr_block.push_back(&mut self.mctx, shr).unwrap();
                        make_result(rd)
                    }
                    (MOperandKind::Reg(reg), MOperandKind::Imm(_, imm)) => {
                        if let Some(imm12) = Imm12::try_from_i64(*imm) {
                            let alu_op = match bitwidth {
                                32 => AluOpRRI::Sraiw,
                                64 => AluOpRRI::Srai,
                                _ => unreachable!("invalid int width"),
                            };
                            let (shr, rd) = MInst::alu_rri(&mut self.mctx, alu_op, *reg, imm12);
                            curr_block.push_back(&mut self.mctx, shr).unwrap();
                            make_result(rd)
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            let alu_op = match bitwidth {
                                32 => AluOpRRR::Sraw,
                                64 => AluOpRRR::Sra,
                                _ => unreachable!("invalid int width"),
                            };
                            let (shr, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, *reg, r);
                            curr_block.push_back(&mut self.mctx, shr).unwrap();
                            make_result(rd)
                        }
                    }
                    _ => unreachable!("invalid operand combination"),
                }
            }
            IntBinaryOp::And | IntBinaryOp::Or | IntBinaryOp::Xor => {
                let op = match op {
                    IntBinaryOp::And => {
                        (AluOpRRR::And, AluOpRRI::Andi)
                    }
                    IntBinaryOp::Or => {
                        (AluOpRRR::Or, AluOpRRI::Ori)
                    }
                    IntBinaryOp::Xor => {
                        (AluOpRRR::Xor, AluOpRRI::Xori)
                    }
                    _ => unreachable!()
                };
    
                match (&lhs_kind, &rhs_kind) {
                    (MOperandKind::Reg(lhs_reg), MOperandKind::Reg(rhs_reg)) => {
                        let (logic, rd) = MInst::alu_rrr(&mut self.mctx, op.0, *lhs_reg, *rhs_reg);
                        curr_block.push_back(&mut self.mctx, logic).unwrap();
                        make_result(rd)
                    }
                    (MOperandKind::Reg(reg), MOperandKind::Imm(_, imm)) |
                    (MOperandKind::Imm(_, imm), MOperandKind::Reg(reg)) => {
                        if let Some(imm12) = Imm12::try_from_i64(*imm) {
                            let (logic, rd) = MInst::alu_rri(&mut self.mctx, op.1, *reg, imm12);
                            curr_block.push_back(&mut self.mctx, logic).unwrap();
                            make_result(rd)
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            let (logic, rd) = MInst::alu_rrr(&mut self.mctx, op.0, *reg, r);
                            curr_block.push_back(&mut self.mctx, logic).unwrap();
                            make_result(rd)
                        }
                    }
                    _ => unreachable!("invalid operand combination"),
                }
            }
            IntBinaryOp::ICmp { cond } => {
                let (lhs_reg, rhs_reg) = match (&lhs_kind, &rhs_kind) {
                    (MOperandKind::Reg(lhs_reg), MOperandKind::Reg(rhs_reg)) => (*lhs_reg, *rhs_reg),
                    (MOperandKind::Reg(reg), MOperandKind::Imm(_, imm)) => {
                        if let Some(imm12) = Imm12::try_from_i64(*imm) {
                            match cond {
                                ir::IntCmpCond::Slt => {
                                    let (slti, rd) = MInst::alu_rri(&mut self.mctx, AluOpRRI::Slti, *reg, imm12);
                                    curr_block.push_back(&mut self.mctx, slti).unwrap();
                                    return make_result(rd);
                                }
                                _ => {
                                    // 其他情况加载到寄存器中比较
                                    let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                                    curr_block.push_back(&mut self.mctx, li).unwrap();
                                    (*reg, r)
                                }
                            }
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            (*reg, r)
                        }
                    }
                    (MOperandKind::Imm(_, imm), MOperandKind::Reg(reg)) => {
                        let (li, r) = MInst::li(&mut self.mctx, *imm as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        (r, *reg)
                    }
                    (MOperandKind::Imm(_, imm1), MOperandKind::Imm(_, imm2)) => {
                        // 编译时计算比较结果
                        let result = match cond {
                            ir::IntCmpCond::Eq => (*imm1 == *imm2) as u64,
                            ir::IntCmpCond::Ne => (*imm1 != *imm2) as u64,
                            ir::IntCmpCond::Slt => (*imm1 < *imm2) as u64,
                            ir::IntCmpCond::Sle => (*imm1 <= *imm2) as u64,
                        };
                        let (li, rd) = MInst::li(&mut self.mctx, result);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        return make_result(rd);
                    }
                    _ => unreachable!("invalid operand combination"),
                };
            
                match cond {
                    ir::IntCmpCond::Eq => {
                        // 用xor和sltiu实现相等比较
                        // xor rd, rs1, rs2     # 如果相等，结果为0
                        // sltiu rd, rd, 1      # 如果xor结果为0，设置为1；否则为0
                        let (xor, rd1) = MInst::alu_rrr(&mut self.mctx, AluOpRRR::Xor, lhs_reg, rhs_reg);
                        curr_block.push_back(&mut self.mctx, xor).unwrap();
                        
                        let imm_zero = Imm12::try_from_i64(1).unwrap();
                        let (sltiu, rd2) = MInst::alu_rri(&mut self.mctx, AluOpRRI::Sltiu, rd1, imm_zero);
                        curr_block.push_back(&mut self.mctx, sltiu).unwrap();
                        make_result(rd2)
                    }
                    ir::IntCmpCond::Ne => {
                        // 用xor实现不相等比较
                        // xor rd, rs1, rs2     # 如果不相等，结果非0
                        // sltu rd, x0, rd      # 如果xor结果非0，设置为1
                        let (xor, rd1) = MInst::alu_rrr(&mut self.mctx, AluOpRRR::Xor, lhs_reg, rhs_reg);
                        curr_block.push_back(&mut self.mctx, xor).unwrap();
                        
                        let (sltu, rd2) = MInst::alu_rrr(
                            &mut self.mctx,
                            AluOpRRR::Sltu,
                            regs::zero().into(),
                            rd1
                        );
                        curr_block.push_back(&mut self.mctx, sltu).unwrap();
                        make_result(rd2)
                    }
                    ir::IntCmpCond::Slt => {
                        // 直接使用slt指令
                        let (slt, rd) = MInst::alu_rrr(&mut self.mctx, AluOpRRR::Slt, lhs_reg, rhs_reg);
                        curr_block.push_back(&mut self.mctx, slt).unwrap();
                        make_result(rd)
                    }
                    ir::IntCmpCond::Sle => {
                        // A <= B 可以用 !(B < A) 实现
                        // slt rd, rs2, rs1     # 检查B < A
                        // xori rd, rd, 1       # 取反得到 A <= B
                        let (slt, rd1) = MInst::alu_rrr(&mut self.mctx, AluOpRRR::Slt, rhs_reg, lhs_reg);
                        curr_block.push_back(&mut self.mctx, slt).unwrap();
                        
                        let imm_one = Imm12::try_from_i64(1).unwrap();
                        let (xori, rd2) = MInst::alu_rri(&mut self.mctx, AluOpRRI::Xori, rd1, imm_one);
                        curr_block.push_back(&mut self.mctx, xori).unwrap();
                        make_result(rd2)
                    }
                }
            }
            // TODO: Add more ops.
        }
    }

    /// Generate a move instruction needed for return value and append it to the
    /// current block. Here we just demonstrate the idea. Bugs may exist.
    /// You can refactor this entirely as your own way.
    fn gen_ret_move(&mut self, val: Value) {
        let curr_block = self.curr_block.unwrap();
        let ty = val.ty(self.ctx);
    
        let src = match &val.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { value } => {
                match value {
                    ir::ConstantValue::Int32 { value, .. } => {
                        if *value == 0 {
                            // 返回0时直接使用零寄存器
                            regs::zero().into()
                        } else {
                            // 将常量加载到寄存器中
                            let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            r
                        }
                    }
                    ir::ConstantValue::Float32 { value, .. } => {
                        todo!("Handle float return value")
                    }
                    ir::ConstantValue::Undef { .. } => {
                        // 未定义值返回0
                        regs::zero().into()
                    }
                    _ => unreachable!("Unsupported constant type for return"),
                }
            }
            ir::ValueKind::InstResult { .. } => {
                let mopd = self.lowered[&val];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Imm(_, imm) => {
                        // 立即数需要加载到寄存器
                        let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    MOperandKind::Mem(loc) => {
                        // 内存中的值需要先加载到寄存器
                        let op = if ty.is_float(self.ctx) {
                            match ty.bitwidth(self.ctx) {
                                32 => LoadOp::Flw,
                                64 => LoadOp::Fld,
                                _ => unreachable!("Invalid float type width"),
                            }
                        } else {
                            match ty.bitwidth(self.ctx) {
                                1 | 8 => LoadOp::Lb,
                                16 => LoadOp::Lh,
                                32 => LoadOp::Lw,
                                64 => LoadOp::Ld,
                                _ => unreachable!("Invalid integer type width"),
                            }
                        };
                        let (load, r) = MInst::load(&mut self.mctx, op, loc);
                        curr_block.push_back(&mut self.mctx, load).unwrap();
                        r
                    }
                    MOperandKind::Undef => regs::zero().into(),
                }
            }
            ir::ValueKind::Param { .. } => {
                // 参数应该已经在lowered map中
                let mopd = self.lowered[&val];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Mem(loc) => {
                        // 参数在栈上需要加载
                        let op = if ty.is_float(self.ctx) {
                            match ty.bitwidth(self.ctx) {
                                32 => LoadOp::Flw,
                                64 => LoadOp::Fld,
                                _ => unreachable!("Invalid float type width"),
                            }
                        } else {
                            match ty.bitwidth(self.ctx) {
                                1 | 8 => LoadOp::Lb,
                                16 => LoadOp::Lh,
                                32 => LoadOp::Lw,
                                64 => LoadOp::Ld,
                                _ => unreachable!("Invalid integer type width"),
                            }
                        };
                        let (load, r) = MInst::load(&mut self.mctx, op, loc);
                        curr_block.push_back(&mut self.mctx, load).unwrap();
                        r
                    }
                    _ => unreachable!("Invalid parameter kind"),
                }
            }
        };
    
        // 根据返回值类型选择目标寄存器和移动指令
        if ty.is_float(self.ctx) {
            // 浮点返回值放在fa0
            todo!("Handle float return value");
        } else {
            // 整数返回值放在a0
            let mv = MInst::raw_alu_rri(
                &mut self.mctx,
                AluOpRRI::Addi,
                regs::a0().into(),
                src,
                Imm12::try_from_i64(0).unwrap(),
            );
            curr_block.push_back(&mut self.mctx, mv).unwrap();
        }
    }

    // TODO: Add more helper functions.

    fn get_operand_kind(&mut self, val: Value) -> MOperandKind {
        match &val.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { value } => {
                match value {
                    ir::ConstantValue::Int32 { value, .. } => {
                        if value == &0 {
                            MOperandKind::Reg(regs::zero().into())
                        } else {
                            MOperandKind::Imm(regs::zero().into(), *value as i64)
                        }
                    }
                    // ir::ConstantValue::Int64 { value, .. } => {
                    //     if value == &0 {
                    //         MOperandKind::Reg(regs::zero().into())
                    //     } else {
                    //         MOperandKind::Imm(regs::zero().into(), *value)
                    //     }
                    // }
                    ir::ConstantValue::Int1 { value, .. } => {
                        if *value {
                            MOperandKind::Imm(regs::zero().into(), *value as i64)
                        } else {
                            MOperandKind::Reg(regs::zero().into())
                        }
                    }
                    _ => todo!("Unsupported constant type"),
                }
            }
            ir::ValueKind::InstResult { .. } => {
                self.lowered[&val].kind
            }
            ir::ValueKind::Param { .. } => {
                todo!("Handle parameters")
            }
        }
    }

    fn get_operand_kinds(&mut self, lhs: Value, rhs: Value) -> (MOperandKind, MOperandKind) {
        let lhs_kind = self.get_operand_kind(lhs);
        let rhs_kind = self.get_operand_kind(rhs); 
        (lhs_kind, rhs_kind)
    }

    fn get_regs_for_op(&mut self, lhs_kind: MOperandKind, rhs_kind: MOperandKind, curr_block: MBlock) -> (Reg, Reg) {
        match (lhs_kind, rhs_kind) {
            (MOperandKind::Reg(lhs_reg), MOperandKind::Reg(rhs_reg)) => (lhs_reg, rhs_reg),
            (MOperandKind::Reg(reg), MOperandKind::Imm(_, imm)) => {
                let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                curr_block.push_back(&mut self.mctx, li).unwrap();
                (reg, r)
            }
            (MOperandKind::Imm(_, imm), MOperandKind::Reg(reg)) => {
                let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                curr_block.push_back(&mut self.mctx, li).unwrap();
                (r, reg)
            }
            (MOperandKind::Imm(_, imm1), MOperandKind::Imm(_, imm2)) => {
                let (li1, r1) = MInst::li(&mut self.mctx, imm1 as u64);
                curr_block.push_back(&mut self.mctx, li1).unwrap();
                let (li2, r2) = MInst::li(&mut self.mctx, imm2 as u64);
                curr_block.push_back(&mut self.mctx, li2).unwrap();
                (r1, r2)
            }
            _ => unreachable!("Invalid operand combination"),
        }
    }

    fn gen_br(&mut self, target: ir::Block) {
        let curr_block = self.curr_block.unwrap();
        let target_block = self.blocks[&target];
        let j = MInst::j(&mut self.mctx, target_block);
        curr_block.push_back(&mut self.mctx, j).unwrap();
    }

    fn gen_cond_br(&mut self, cond: Value, then_bb: ir::Block, else_bb: ir::Block) {
        let curr_block = self.curr_block.unwrap();

        // 获取条件值所在寄存器
        let cond_reg = match &cond.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { value } => {
                match value {
                    ir::ConstantValue::Int32 { value, .. } => {
                        if *value != 0 {
                            // 条件为常量true,直接跳转到then分支
                            self.gen_br(then_bb);
                        } else {
                            // 条件为常量false,直接跳转到else分支  
                            self.gen_br(else_bb);
                        }
                        return;
                    }
                    ir::ConstantValue::Int1 { value, .. } => {
                        if *value {
                            self.gen_br(then_bb);
                        } else {
                            self.gen_br(else_bb);
                        }
                        return;
                    }
                    _ => unreachable!("Invalid constant type for condition"),
                }
            }
            ir::ValueKind::InstResult { .. } => {
                let mopd = self.lowered[&cond];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Imm(_, imm) => {
                        // 立即数需要先加载到寄存器
                        let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r 
                    }
                    MOperandKind::Mem(loc) => {
                        // 内存中的条件值需要加载到寄存器
                        let (load, r) = MInst::load(&mut self.mctx, LoadOp::Lw, loc);
                        curr_block.push_back(&mut self.mctx, load).unwrap();
                        r
                    }
                    MOperandKind::Undef => {
                        // 未定义值视为false
                        self.gen_br(else_bb);
                        return;
                    }
                }
            }
            ir::ValueKind::Param { .. } => {
                let mopd = self.lowered[&cond];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Mem(loc) => {
                        // 参数在栈上需要加载到寄存器
                        let (load, r) = MInst::load(&mut self.mctx, LoadOp::Lw, loc);
                        curr_block.push_back(&mut self.mctx, load).unwrap();
                        r
                    }
                    _ => unreachable!("Invalid parameter kind"),
                }
            }
        };

        // 生成条件跳转序列:
        // bne cond, zero, then_label  # if cond != 0 goto then
        // j else_label                # else goto else
        
        let then_block = self.blocks[&then_bb];
        let else_block = self.blocks[&else_bb];

        // 使用正确的寄存器生成条件跳转
        let br = MInst::br(&mut self.mctx, BrOp::Bne, cond_reg, regs::zero().into(), then_block);
        curr_block.push_back(&mut self.mctx, br).unwrap();

        // 再生成 j 到 else 分支 
        let j = MInst::j(&mut self.mctx, else_block);
        curr_block.push_back(&mut self.mctx, j).unwrap();
    }

    fn gen_cast(&mut self, op: &ir::CastOp, val: Value, target_ty: Ty) -> MOperand {
        let curr_block = self.curr_block.unwrap();
        let src_ty = val.ty(self.ctx);
        
        // 获取源值对应的寄存器
        let src_reg = match &val.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { value } => {
                match value {
                    ir::ConstantValue::Int32 { value, .. } => {
                        if *value == 0 {
                            regs::zero().into()
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            r
                        }
                    }
                    ir::ConstantValue::Undef { .. } => {
                        regs::zero().into()
                    }
                    _ => todo!("Unsupported constant type for cast")
                }
            }
            ir::ValueKind::InstResult { .. } => {
                let mopd = self.lowered[&val];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Imm(_, imm) => {
                        let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    MOperandKind::Mem(loc) => {
                        let op = match src_ty.bitwidth(self.ctx) {
                            8 => LoadOp::Lb,
                            16 => LoadOp::Lh,
                            32 => LoadOp::Lw,
                            64 => LoadOp::Ld,
                            _ => unreachable!()
                        };
                        let (load, r) = MInst::load(&mut self.mctx, op, loc);
                        curr_block.push_back(&mut self.mctx, load).unwrap();
                        r
                    }
                    MOperandKind::Undef => regs::zero().into()
                }
            }
            ir::ValueKind::Param { .. } => {
                let mopd = self.lowered[&val];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Mem(loc) => {
                        let op = match src_ty.bitwidth(self.ctx) {
                            8 => LoadOp::Lb,
                            16 => LoadOp::Lh,
                            32 => LoadOp::Lw,
                            64 => LoadOp::Ld,
                            _ => unreachable!()
                        };
                        let (load, r) = MInst::load(&mut self.mctx, op, loc);
                        curr_block.push_back(&mut self.mctx, load).unwrap();
                        r
                    }
                    _ => unreachable!("Invalid parameter kind")
                }
            }
        };

        match op {
            ir::CastOp::Zext => {
                // 零扩展使用无符号加载指令
                let rd: Reg = self.mctx.new_vreg(RegKind::General).into();
                match src_ty.bitwidth(self.ctx) {
                    1 => {
                        let (andi, rd) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Andi,
                            src_reg,
                            Imm12::try_from_i64(1).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, andi).unwrap();
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd)
                        }
                    }
                    8 => {
                        // 使用 lbu 实现 i8 到更大类型的零扩展
                        let (andi, rd) = MInst::alu_rri(
                            &mut self.mctx, 
                            AluOpRRI::Andi, 
                            src_reg,
                            Imm12::try_from_i64(0xff).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, andi).unwrap();
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd)
                        }
                    }
                    16 => {
                        // 使用 andi 实现 i16 到更大类型的零扩展
                        let (andi, rd) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Andi,
                            src_reg,
                            Imm12::try_from_i64(0xffff).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, andi).unwrap();
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd)
                        }
                    }
                    32 => {
                        // 使用 slli+srli 实现 i32 到 i64 的零扩展
                        let (slli, rd1) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Slli,
                            src_reg,
                            Imm12::try_from_i64(32).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, slli).unwrap();
                        
                        let (srli, rd2) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Srli,
                            rd1,
                            Imm12::try_from_i64(32).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, srli).unwrap();
                        
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd2)
                        }
                    }
                    _ => unreachable!("Invalid source type for zext")
                }
            }
            ir::CastOp::Sext => {
                let rd: Reg = self.mctx.new_vreg(RegKind::General).into();
                match src_ty.bitwidth(self.ctx) {
                    8 => {
                        // 使用 slli+srai 实现 i8 到更大类型的符号扩展
                        let (slli, rd1) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Slli,
                            src_reg,
                            Imm12::try_from_i64(56).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, slli).unwrap();
                        
                        let (srai, rd2) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Srai,
                            rd1,
                            Imm12::try_from_i64(56).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, srai).unwrap();
                        
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd2)
                        }
                    }
                    16 => {
                        // 使用 slli+srai 实现 i16 到更大类型的符号扩展
                        let (slli, rd1) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Slli,
                            src_reg,
                            Imm12::try_from_i64(48).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, slli).unwrap();
                        
                        let (srai, rd2) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Srai,
                            rd1,
                            Imm12::try_from_i64(48).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, srai).unwrap();
                        
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd2)
                        }
                    }
                    32 => {
                        // 使用 addiw 实现 i32 到 i64 的符号扩展
                        let (addiw, rd) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Addiw,
                            src_reg,
                            Imm12::try_from_i64(0).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, addiw).unwrap();
                        
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd)
                        }
                    }
                    _ => unreachable!("Invalid source type for sext")
                }
            }
            ir::CastOp::Trunc => {
                let rd: Reg = self.mctx.new_vreg(RegKind::General).into();
                match target_ty.bitwidth(self.ctx) {
                    8 => {
                        // 使用 andi 实现截断到 i8 
                        let (andi, rd) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Andi,
                            src_reg,
                            Imm12::try_from_i64(0xff).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, andi).unwrap();
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd)
                        }
                    }
                    16 => {
                        // 使用 andi 实现截断到 i16
                        let (andi, rd) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Andi,
                            src_reg, 
                            Imm12::try_from_i64(0xffff).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, andi).unwrap();
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd)
                        }
                    }
                    32 => {
                        // 使用 addiw 实现截断到 i32
                        let (addiw, rd) = MInst::alu_rri(
                            &mut self.mctx,
                            AluOpRRI::Addiw,
                            src_reg,
                            Imm12::try_from_i64(0).unwrap()
                        );
                        curr_block.push_back(&mut self.mctx, addiw).unwrap();
                        MOperand {
                            ty: target_ty,
                            kind: MOperandKind::Reg(rd)
                        }
                    }
                    _ => unreachable!("Invalid target type for trunc")
                }
            }
            ir::CastOp::SiToFp => todo!("SiToFp not implemented"),
            ir::CastOp::FpToSi => todo!("FpToSi not implemented"),
        }
    }

}

#[derive(Debug, Clone)]
struct LiveInterval {
    vreg: Reg,               // 虚拟寄存器
    start: usize,            // 开始位置
    end: usize,             // 结束位置
    uses: Vec<usize>,       // 使用点
    assigned_reg: Option<PReg>, // 分配的物理寄存器
    spill_slot: Option<i64>,   // 溢出位置
}

#[derive(Clone, Copy)]
enum RegUpdate {
    Def(Reg),
    Use(Reg),
}

impl LiveInterval {
    fn new(vreg: Reg) -> Self {
        Self {
            vreg,
            start: usize::MAX,
            end: 0,
            uses: Vec::new(),
            assigned_reg: None,
            spill_slot: None,
        }
    }

    fn overlaps_with(&self, other: &LiveInterval) -> bool {
        !(self.end < other.start || self.start > other.end)
    }
}

impl<'s> CodegenContext<'s> {
    pub fn regalloc(&mut self) {
        let available_regs = vec![
            regs::t0(), regs::t1(), regs::t2(), 
            regs::t3(), regs::t4(), regs::t5(), regs::t6(),
        ];

        let funcs: Vec<MFunc> = self.funcs.values().copied().collect();

        for &func in &funcs {
            self.compute_live_intervals(func);

            let mut sorted_intervals: Vec<_> = self.live_intervals.values().cloned().collect();
            sorted_intervals.sort_by_key(|interval| interval.start);

            let mut active: Vec<LiveInterval> = Vec::new();
            let mut free_regs: Vec<PReg> = available_regs.clone();
            let mut reg_map: HashMap<Reg, Reg> = HashMap::new();

            for mut interval in sorted_intervals {
                active.retain(|act| {
                    if act.end < interval.start {
                        if let Some(preg) = act.assigned_reg {
                            free_regs.push(preg);
                        }
                        false
                    } else {
                        true
                    }
                });

                if free_regs.is_empty() {
                    self.handle_spill(&mut interval, &mut active, func);
                } else {
                    let preg = free_regs.pop().unwrap();
                    interval.assigned_reg = Some(preg);
                    reg_map.insert(interval.vreg, preg.into());
                }

                if interval.assigned_reg.is_some() {
                    active.push(interval);
                    active.sort_by_key(|int| int.end);
                }
            }

            self.update_registers(func, &reg_map);
        }
    }

    fn handle_spill(&mut self, interval: &mut LiveInterval, active: &mut Vec<LiveInterval>, func: MFunc) {
        // 找出最晚使用的活跃区间的索引
        let spill_idx = active.iter()
            .enumerate()
            .max_by_key(|(_, int)| {
                int.uses.iter()
                    .find(|&&pos| pos > interval.start)
                    .copied()
                    .unwrap_or(int.end)
            })
            .map(|(idx, _)| idx);

        if let Some(spill_idx) = spill_idx {
            let next_use_spill = active[spill_idx].uses.iter()
                .find(|&&pos| pos > interval.start)
                .copied()
                .unwrap_or(active[spill_idx].end);

            let next_use_current = interval.uses.iter()
                .find(|&&pos| pos > interval.start)
                .copied()
                .unwrap_or(interval.end);

            if next_use_spill > next_use_current {
                // 溢出已有区间
                let preg = active[spill_idx].assigned_reg.take();
                if let Some(preg) = preg {
                    interval.assigned_reg = Some(preg);
                    // 为溢出的区间分配栈空间
                    if active[spill_idx].spill_slot.is_none() {
                        let offset = -(func.storage_stack_size(&self.mctx) as i64 + 8);
                        func.add_storage_stack_size(&mut self.mctx, 8);
                        active[spill_idx].spill_slot = Some(offset);
                    }
                }
            } else {
                // 溢出当前区间
                let offset = -(func.storage_stack_size(&self.mctx) as i64 + 8);
                func.add_storage_stack_size(&mut self.mctx, 8);
                interval.spill_slot = Some(offset);
            }
        }
    }

    // 计算活跃区间
    fn compute_live_intervals(&mut self, func: MFunc) {
        self.inst_index = 0;
        self.live_intervals.clear();

        // 先收集所有寄存器更新信息
        let mut all_updates = Vec::new();
        let mut curr_block = func.head(&self.mctx);
        
        while let Some(block) = curr_block {
            let mut curr_inst = block.head(&self.mctx);
            while let Some(inst) = curr_inst {
                let mut updates = Vec::new();
                
                // 收集当前指令的所有寄存器更新
                match inst.kind(&self.mctx) {
                    MInstKind::AluRRI { rd, rs, .. } => {
                        updates.push(RegUpdate::Def(*rd));
                        updates.push(RegUpdate::Use(*rs));
                    }
                    MInstKind::AluRRR { rd, rs1, rs2, .. } => {
                        updates.push(RegUpdate::Def(*rd));
                        updates.push(RegUpdate::Use(*rs1));
                        updates.push(RegUpdate::Use(*rs2));
                    }
                    MInstKind::Load { rd, loc, .. } => {
                        updates.push(RegUpdate::Def(*rd));
                        // 添加对基址寄存器的使用
                        if let MemLoc::RegOffset { base, .. } = loc {
                            updates.push(RegUpdate::Use(*base));
                        }
                    }
                    MInstKind::Store { rs, loc, .. } => {
                        updates.push(RegUpdate::Use(*rs));
                        // 添加对基址寄存器的使用
                        if let MemLoc::RegOffset { base, .. } = loc {
                            updates.push(RegUpdate::Use(*base));
                        }
                    }
                    MInstKind::Li { rd, .. } => {
                        updates.push(RegUpdate::Def(*rd));
                    }
                    MInstKind::Br { rs1, rs2, .. } => {
                        updates.push(RegUpdate::Use(*rs1));
                        updates.push(RegUpdate::Use(*rs2));
                    }
                    MInstKind::La { rd, .. } => {
                        updates.push(RegUpdate::Def(*rd));
                    }
                    _ => {}
                }
                
                all_updates.push((self.inst_index, updates));
                self.inst_index += 1;
                curr_inst = inst.next(&self.mctx);
            }
            curr_block = block.next(&self.mctx);
        }

        // 处理收集到的更新信息
        for (inst_idx, updates) in all_updates {
            self.inst_index = inst_idx;
            for update in updates {
                match update {
                    RegUpdate::Def(reg) => {
                        if reg.is_vreg() {
                            let interval = self.live_intervals
                                .entry(reg)
                                .or_insert_with(|| LiveInterval::new(reg));
                            interval.start = interval.start.min(self.inst_index);
                            interval.end = interval.end.max(self.inst_index);
                            interval.uses.push(self.inst_index);
                        }
                    }
                    RegUpdate::Use(reg) => {
                        if reg.is_vreg() {
                            let interval = self.live_intervals
                                .entry(reg)
                                .or_insert_with(|| LiveInterval::new(reg));
                            interval.end = interval.end.max(self.inst_index);
                            interval.uses.push(self.inst_index);
                        }
                    }
                }
            }
        }
    }

    fn update_registers(&mut self, func: MFunc, reg_map: &HashMap<Reg, Reg>) {
        // 先收集所有需要更新的寄存器
        let mut updates = Vec::new();
        
        let mut curr_block = func.head(&self.mctx);
        while let Some(block) = curr_block {
            let mut curr_inst = block.head(&self.mctx);
            while let Some(inst) = curr_inst {
                let mut inst_updates = Vec::new();
                
                match inst.kind(&self.mctx) {
                    MInstKind::AluRRI { rd, rs, .. } => {
                        inst_updates.push((*rd, reg_map.get(rd)));
                        inst_updates.push((*rs, reg_map.get(rs)));
                    }
                    MInstKind::AluRRR { rd, rs1, rs2, .. } => {
                        inst_updates.push((*rd, reg_map.get(rd)));
                        inst_updates.push((*rs1, reg_map.get(rs1)));
                        inst_updates.push((*rs2, reg_map.get(rs2)));
                    }
                    MInstKind::Load { rd, loc, .. } => {
                        inst_updates.push((*rd, reg_map.get(rd)));
                        // 添加对基址寄存器的更新
                        if let MemLoc::RegOffset { base, .. } = loc {
                            inst_updates.push((*base, reg_map.get(base)));
                        }
                    }
                    MInstKind::Store { rs, loc, .. } => {
                        inst_updates.push((*rs, reg_map.get(rs)));
                        // 添加对基址寄存器的更新
                        if let MemLoc::RegOffset { base, .. } = loc {
                            inst_updates.push((*base, reg_map.get(base)));
                        }
                    }
                    MInstKind::Li { rd, .. } => {
                        inst_updates.push((*rd, reg_map.get(rd)));
                    }
                    MInstKind::Br { rs1, rs2, .. } => {
                        inst_updates.push((*rs1, reg_map.get(rs1)));
                        inst_updates.push((*rs2, reg_map.get(rs2)));
                    }
                    MInstKind::La { rd, .. } => {
                        inst_updates.push((*rd, reg_map.get(rd)));
                    }
                    _ => {}
                }
                
                updates.push((inst, inst_updates));
                curr_inst = inst.next(&self.mctx);
            }
            curr_block = block.next(&self.mctx);
        }

        // 一次性应用所有更新
        for (inst, inst_updates) in updates {
            match &mut inst.kind_mut(&mut self.mctx) {
                MInstKind::AluRRI { rd, rs, .. } => {
                    if let Some(&new_reg) = inst_updates[0].1 {
                        *rd = new_reg;
                    }
                    if let Some(&new_reg) = inst_updates[1].1 {
                        *rs = new_reg;
                    }
                }
                MInstKind::AluRRR { rd, rs1, rs2, .. } => {
                    if let Some(&new_reg) = inst_updates[0].1 {
                        *rd = new_reg;
                    }
                    if let Some(&new_reg) = inst_updates[1].1 {
                        *rs1 = new_reg;
                    }
                    if let Some(&new_reg) = inst_updates[2].1 {
                        *rs2 = new_reg;
                    }
                }
                MInstKind::Load { rd, loc, .. } => {
                    if let Some(&new_reg) = inst_updates[0].1 {
                        *rd = new_reg;
                    }
                    if let MemLoc::RegOffset { base, .. } = loc {
                        if let Some(&new_reg) = inst_updates[1].1 {
                            *base = new_reg;
                        }
                    }
                }
                MInstKind::Store { rs, loc, .. } => {
                    if let Some(&new_reg) = inst_updates[0].1 {
                        *rs = new_reg;
                    }
                    if let MemLoc::RegOffset { base, .. } = loc {
                        if let Some(&new_reg) = inst_updates[1].1 {
                            *base = new_reg;
                        }
                    }
                }
                MInstKind::Li { rd, .. } => {
                    if let Some(&new_reg) = inst_updates[0].1 {
                        *rd = new_reg;
                    }
                }
                MInstKind::Br { rs1, rs2, .. } => {
                    if let Some(&new_reg) = inst_updates[0].1 {
                        *rs1 = new_reg;
                    }
                    if let Some(&new_reg) = inst_updates[1].1 {
                        *rs2 = new_reg;
                    }
                }
                MInstKind::La { rd, .. } => {
                    if let Some(&new_reg) = inst_updates[0].1 {
                        *rd = new_reg;
                    }
                }
                _ => {}
            }
        }
    }
}