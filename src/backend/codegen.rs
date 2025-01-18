//! Target Code Generation.
//!
//! The assembly code is generated here.

use std::any::Any;
use std::collections::{HashMap, VecDeque};

use super::block::MBlock;
use super::context::MContext;
use super::func::{MFunc, MLabel};
use super::imm::Imm12;
use super::inst::{AluOpRRI, AluOpRRR, LoadOp, MInst, MInstKind, StoreOp};
use super::operand::{MOperand, MOperandKind, MemLoc};
use super::regs::{self, Reg};
use crate::backend::regs::{PReg, RegKind};
use crate::backend::inst::BranchOp;
use crate::infra::linked_list::{LinkedListContainer, LinkedListNode};
use crate::infra::storage::ArenaPtr;
use crate::ir::{self, ConstantValue, IntBinaryOp, Ty, Value, ValueKind};
use crate::backend::context::RawData;
use crate::ir::FuncKind;
use crate::ir::TyData;

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
        }
    }

    /// Finish the code generation and return the machine code context.
    pub fn finish(self) -> MContext { self.mctx }

    /// Get a reference to the machine code context.
    pub fn mctx(&self) -> &MContext { &self.mctx }

    /// Get a mutable reference to the machine code context.
    pub fn mctx_mut(&mut self) -> &mut MContext { &mut self.mctx }

    /// Do the code generation.
    pub fn codegen(&mut self) {
        // TODO✔: There are several things to be handled before translating instructions:
        // Generate plcaceholders for all the functions and blocks.
        for func in self.ctx.funcs() {
            let name = func.name(self.ctx);
            let label = MLabel::from(name);
            
            let mfunc = MFunc::new(&mut self.mctx, label);
            self.funcs.insert(name.to_string(), mfunc);

            //  1. External functions and corresponding signatures.
            match func.kind(&mut self.ctx) {
                FuncKind::Declare => {
                    mfunc.set_externel(&mut self.mctx, true);
                    self.funcs.insert(name.to_string(), mfunc);
                }
                FuncKind::Define => {
                    self.funcs.insert(name.to_string(), mfunc);
                    for block in func.iter(self.ctx) {
                        let mblock = MBlock::new(&mut self.mctx, format!(".{}", block.name(self.ctx)));
                        let _ = mfunc.push_back(&mut self.mctx, mblock);
                        self.blocks.insert(block, mblock);
                    }
                }
            }
        }

        //  2. Global variables/constants.
        for global_data in self.ctx.globals.iter() {
            let name = &global_data.name;  // 获取全局变量的名字
            let label = MLabel::from(name);  // 创建全局变量标签
            self.globals.insert(name.to_string(), label.clone());

            // 处理 global_data.value，根据不同类型進行选择
            let ty = global_data.self_ptr.ty(&self.ctx); // 获取全局变量的类型
            let init_value = global_data.self_ptr.value(&self.ctx); // 获取全局变量的初始值（如果有）
            self.emit_global_data(label, ty, init_value);
        }

        // XXX: This is just a demonstration, you may refactor this part entirely.
        for func in self.ctx.funcs() {
            self.curr_func = Some(self.funcs[func.name(self.ctx)]);
            let mfunc = self.curr_func.unwrap();

            if mfunc.is_external(&self.mctx) {
                continue;
            }

            // TODO: Incoming parameters can be handled here.
            for (i, param) in func.params(self.ctx).iter().enumerate() {
                let mopd = if i < 8 {
                    let reg = match param.ty(self.ctx).kind(self.ctx) {
                        ir::TyData::Int1 | ir::TyData::Int8 | ir::TyData::Int32 => {
                            regs::get_arg(i).into()
                        }
                        ir::TyData::Float32 => todo!("handle float point registers"),
                        ir::TyData::Ptr { .. } | ir::TyData::Array { .. } => {
                            regs::get_arg(i).into()
                        }
                        _ => {
                            eprintln!(
                                "Unsupported parameter type: {}",
                                param.ty(self.ctx).display(&self.ctx)
                            );
                            eprintln!("Error in func: {}", func.display(&self.ctx));
                            unreachable!()
                        }
                    };
                    MOperand {
                        ty: param.ty(self.ctx),
                        kind: MOperandKind::Reg(reg),
                    }
                } else {
                    let offset = (i - 8) * 8;
                    let mem_loc = MemLoc::Slot {
                        offset: offset as i64,
                    };
                    MOperand {
                        ty: param.ty(self.ctx),
                        kind: MOperandKind::Mem(mem_loc),
                    }
                };
                self.lowered.insert(param.clone(), mopd);
            }

            // XXX: You can use dominance/cfg to generate better assembly.

            // Translate the instructions.
            for block in func.iter(self.ctx) {
                self.curr_block = Some(self.blocks[&block]);
                let mblock = self.curr_block.unwrap();

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
                            let ptr: Value = inst.operand(self.ctx, 1);
                            let memloc = self.memloc_from_value(&ptr);
                            // Here we use a helper function to generate the store instruction.
                            // You can change the implementation of the helper functions as you
                            // like. Or you can also not use helper functions.
                            self.gen_store(val, memloc);
                        }
                        ir::InstKind::Load => {
                           let ptr = inst.operand(self.ctx, 0);
                            let memloc = self.memloc_from_value(&ptr);
                            let ty = inst.result(self.ctx).unwrap().ty(self.ctx);
                            let mopd = self.gen_load(ty, memloc);
                            self.lowered.insert(inst.result(self.ctx).unwrap(), mopd);
                        }
                        ir::InstKind::IntBinary { op } => {
                            // TODO: Here's a simple example, you may need to handle more cases.
                            let lhs = inst.operand(self.ctx, 0);
                            let rhs = inst.operand(self.ctx, 1);
                            let mopd = self.gen_int_binary(*op, lhs, rhs);
                            self.lowered.insert(inst.result(self.ctx).unwrap(), mopd);
                        }
                        ir::InstKind::Ret => {
                            // TODO: You can handle multiple return values as you like.
                            if inst.operand_iter(self.ctx).count() == 1 {
                                let val = inst.operand(self.ctx, 0);
                                self.gen_ret_move(val);
                            }
                            // The `ret` should be generated in function
                            // epilogue, after register allocation.
                        }
                        &ir::InstKind::Br => {
                            // You can also encapsulate this into a helper function for cleaner
                            // code.
                            if inst.operand_iter(self.ctx).count() == 0 {
                                // Unconditional branch.
                                let target = inst.successor(self.ctx, 0);
                                let target_block = self.blocks[&target];
                                let j = MInst::j(&mut self.mctx, target_block);
                                mblock.push_back(&mut self.mctx, j).unwrap();
                            } 
                        }
                        // TODO: Add more instuctions.
                        ir::InstKind::CondBr => {
                             // 获取条件操作数和目标基本块
                             let cond = inst.operand(self.ctx, 0); // 条件操作数
                             let then_dst = inst.successor(self.ctx, 0); // 条件为真时跳转的目标块
                             let else_dst = inst.successor(self.ctx, 1); // 条件为假时跳转的目标块（如果存在）
 
                             // 获取对应的基本块
                             let then_block = self.blocks[&then_dst];
 
                             // 处理 else 块（如果映射失败，则为 None）
                             let else_block = if self.blocks.contains_key(&else_dst) {
                                 Some(self.blocks[&else_dst])
                             } else {
                                 None
                             };
 
                             // 获取当前块的下一个块，作为结束块
                             let end_block = self.blocks[&block.next(self.ctx).unwrap()];
 
                             // 调用 gen_cond_branch 方法生成条件分支指令
                             self.gen_cond_branch(cond, then_block, else_block, end_block);
                        }
                        ir::InstKind::Call { name } => {
                            // let callee = inst.operand(&self.ctx, 0);
                            // let args: Vec<_> = inst.operand_iter(&self.ctx).skip(1).collect();
                            // let ret = match inst.result(&self.ctx) {
                            //     Some(ret) => {
                            //         if ret.ty(&self.ctx).is_void(&self.ctx) {
                            //             None
                            //         } else {
                            //             Some(ret)
                            //         }
                            //     }
                            //     None => None,
                            // };
                            // let callee_name = match &callee.try_deref(&self.ctx).unwrap().kind {
                            //     ir::ValueKind::Constant { value } => match value {
                            //         ir::ConstantValue::GlobalRef { name, .. } => name,
                            //         _ => {
                            //             eprintln!("Unsupported callee: {:?}", callee);
                            //             unreachable!()
                            //         }
                            //     },
                            //     _ => {
                            //         eprintln!("Unsupported callee: {:?}", callee);
                            //         unreachable!()
                            //     }
                            // };
                            // let reg = self.gen_call(callee_name, args, ret);
                            // if let Some(reg) = reg {
                            //     self.lowered.insert(ret.unwrap(), reg);
                            // }
                        }
                        ir::InstKind::GetElementPtr { bound_ty } => {
                            let base = inst.operand(&self.ctx, 0);
                            let offsets = inst.operand_iter(&self.ctx).skip(1).collect();
                            let dst = inst.result(&self.ctx).unwrap();
                            let mopd = self.gen_gep(&base, offsets, bound_ty);
                            self.lowered.insert(dst, mopd);
                        }
                        _ => {
                            todo!()
                        }
                    }
                }
            }
        }
    }

    pub fn regalloc(&mut self) {
        // This is an extremely simple register allocator, which just assigns
        // the first available register to each virtual register. It's only for
        // demonstration.
        // TODO: You need to implement a real register allocator to replace this.
        let mut available_regs = vec![
            regs::t0(),
            regs::t1(),
            regs::t2(),
            regs::t3(),
            regs::t4(),
            regs::t5(),
            regs::t6(),
        ];

        for function in self.funcs.values() {
            let mut reg_map: HashMap<Reg, Reg> = HashMap::new();

            // Map virtual registers to physical registers.
            for block in function.iter(&self.mctx) {
                for inst in block.iter(&self.mctx) {
                    match inst.kind(self.mctx()) {
                        MInstKind::AluRRI { rd, rs, .. } => {
                            for reg in [rd, rs] {
                                if reg.is_vreg() && !reg_map.contains_key(reg) {
                                    let preg = available_regs.pop().unwrap();
                                    reg_map.insert(*reg, preg.into());
                                }
                            }
                        }
                        MInstKind::AluRRR { rd, rs1, rs2, .. } => {
                            for reg in [rd, rs1, rs2] {
                                if reg.is_vreg() && !reg_map.contains_key(reg) {
                                    let preg = available_regs.pop().unwrap();
                                    reg_map.insert(*reg, preg.into());
                                }
                            }
                        }
                        MInstKind::Load { rd, .. } => {
                            if rd.is_vreg() && !reg_map.contains_key(rd) {
                                let preg = available_regs.pop().unwrap();
                                reg_map.insert(*rd, preg.into());
                            }
                        }
                        MInstKind::Store { rs, .. } => {
                            if rs.is_vreg() && !reg_map.contains_key(rs) {
                                let preg = available_regs.pop().unwrap();
                                reg_map.insert(*rs, preg.into());
                            }
                        }
                        MInstKind::Li { rd, .. } => {
                            if rd.is_vreg() && !reg_map.contains_key(rd) {
                                let preg = available_regs.pop().unwrap();
                                reg_map.insert(*rd, preg.into());
                            }
                        }
                        MInstKind::J { .. } => {}, /* XXX: We do not encourage using this naive
                                                         * register allocator in your work. But if you
                                                         * really want to use, you may need to handle
                                                         * other instructions. */
                        MInstKind::Jr { rd } => {},
                        MInstKind::La { rd, loc } => {},
                        MInstKind::Branch { op, rs1, rs2, target } => {},
                        MInstKind::Call { target } => {},
                        MInstKind::Ret => {},
                    }
                }
            }

            // Replace virtual registers with physical registers.
            let mut curr_block = function.head(&self.mctx);
            while let Some(block) = curr_block {
                let mut curr_inst = block.head(&self.mctx);
                while let Some(inst) = curr_inst {
                    match &mut inst.kind_mut(&mut self.mctx) {
                        MInstKind::AluRRI { rd, rs, .. } => {
                            for reg in [rd, rs] {
                                if let Some(vreg) = reg_map.get(reg) {
                                    *reg = *vreg;
                                }
                            }
                        }
                        MInstKind::AluRRR { rd, rs1, rs2, .. } => {
                            for reg in [rd, rs1, rs2] {
                                if let Some(vreg) = reg_map.get(reg) {
                                    *reg = *vreg;
                                }
                            }
                        }
                        MInstKind::Load { rd, .. } => {
                            if let Some(vreg) = reg_map.get(rd) {
                                *rd = *vreg;
                            }
                        }
                        MInstKind::Store { rs, .. } => {
                            if let Some(vreg) = reg_map.get(rs) {
                                *rs = *vreg;
                            }
                        }
                        MInstKind::Li { rd, .. } => {
                            if let Some(vreg) = reg_map.get(rd) {
                                *rd = *vreg;
                            }
                        }
                        MInstKind::J { .. } => {}, /* XXX: We do not encourage using this naive
                                                         * register allocator in your work. But if you
                                                         * really want to use, you may need to handle
                                                         * other instructions. */
                        MInstKind::Jr { rd } => {},
                        MInstKind::La { rd, loc } => {},
                        MInstKind::Branch { op, rs1, rs2, target } => {},
                        MInstKind::Call { target } => {},
                        MInstKind::Ret => {},
                    }
                    curr_inst = inst.next(&self.mctx);
                }
                curr_block = block.next(&self.mctx);
            }
        }
    }

    /// Do the code generation after register allocation.
    pub fn after_regalloc(&mut self) {
        // TODO✔: The stack frame is determined after register allocation, so
        // we need to add instructions to adjust the stack frame.
        //
        // There should be two stages:
        //  1. Prologue: Save the callee-saved registers and adjust the stack frame.
        //  2. Epilogue: Restore the callee-saved registers and handle return.
        //
        // Depending on your implementation, you may need to adjust stack slots
        // offsets after these two stages.

        // 获取当前函数和基本块
        for func in self.ctx.funcs(){
            self.curr_func = Some(self.funcs[func.name(self.ctx)]);
            let mfunc = self.curr_func.unwrap();

            if mfunc.is_external(&self.mctx){
                continue;
            }
        
            // 假设需要保存寄存器ra和fp
             // TODO: Assuming that we need fixed 32 byte for stak frame (should be flexible instead)
            let adjust_stack_size = 32;

            // 1. 添加栈帧调整代码到函数的开头（前言阶段）
            let mut curr_block = mfunc.head(&self.mctx);
            if let Some(prologue_block) = curr_block {
                // 保存ra和fp到栈
                let store_ra = MInst::store(
                    &mut self.mctx,
                    StoreOp::Sw,
                    Reg::P(PReg::new(1, RegKind::General)), // ra
                    MemLoc::Slot { offset: -adjust_stack_size as i64 }
                );
                prologue_block.push_front(&mut self.mctx, store_ra).unwrap();

                let store_fp = MInst::store(
                    &mut self.mctx,
                    StoreOp::Sw,
                    Reg::P(PReg::new(2, RegKind::General)), // fp
                    MemLoc::Slot { offset: -(adjust_stack_size as i64 - 4) }
                );
                prologue_block.push_front(&mut self.mctx, store_fp).unwrap();

                // 更新栈指针sp
                let adjust_sp = MInst::raw_alu_rri(
                    &mut self.mctx,
                    AluOpRRI::Addi,
                    Reg::P(PReg::new(2, RegKind::General)), // fp
                    Reg::P(PReg::new(2, RegKind::General)), // fp
                    Imm12::try_from_i64(-adjust_stack_size).unwrap()
                );
                prologue_block.push_front(&mut self.mctx, adjust_sp).unwrap();
            }

            // 2. 添加栈帧恢复代码到函数的结尾（结语阶段）
            curr_block = mfunc.tail(&self.mctx);
            if let Some(epilogue_block) = curr_block{
                // 恢复 fp 和 ra 寄存器
                let store_ra = MInst::store(
                    &mut self.mctx,
                    StoreOp::Sw,
                    Reg::P(PReg::new(1, RegKind::General)), // ra
                    MemLoc::Slot { offset: -adjust_stack_size as i64 }
                );
                epilogue_block.push_front(&mut self.mctx, store_ra).unwrap();

                let store_fp = MInst::store(
                    &mut self.mctx,
                    StoreOp::Sw,
                    Reg::P(PReg::new(2, RegKind::General)), // fp
                    MemLoc::Slot { offset: -(adjust_stack_size as i64 - 4) }
                );
                epilogue_block.push_front(&mut self.mctx, store_fp).unwrap();

                 // 恢复栈指针
                let restore_sp = MInst::raw_alu_rri(
                    &mut self.mctx,
            AluOpRRI::Addi,
                    Reg::P(PReg::new(2, RegKind::General)), // fp
                    Reg::P(PReg::new(2, RegKind::General)), // fp
                    Imm12::try_from_i64(adjust_stack_size).unwrap()
                );
                epilogue_block.push_back(&mut self.mctx, restore_sp).unwrap();
            }

            // 3.返回函数调用地址
            let jr = MInst::jr(
                &mut self.mctx,
                Reg::P(PReg::new(1, RegKind::General)),
            );
            let _ = curr_block.unwrap().push_back(&mut self.mctx, jr);
        }
    }

    /// Emit the assembly code.
    ///
    /// It's not necessary to implement this function, you can also handle the
    /// emission directly in `main.rs`.
    pub fn emit(&mut self) {
        // TODO: Emit the assembly code.
    }

    pub fn emit_global_data(&mut self, label: MLabel, ty: Ty, init_value: &ir::ConstantValue) {
        let size = (ty.bitwidth(self.ctx) + 7) / 8;
        let raw_data = match init_value {
            ir::ConstantValue::Int1 { value, .. } => {
                let bytes = vec![*value as u8];
                RawData::Bytes(bytes)
            }
            ir::ConstantValue::Int8 { value, .. } => {
                let bytes = value.to_le_bytes().to_vec();
                RawData::Bytes(bytes)
            }
            ir::ConstantValue::Int32 { value, .. } => {
                // 将整数值按字节存储到 `.data` 段
                let bytes = value.to_le_bytes().to_vec();
                RawData::Bytes(bytes)
            }
            ir::ConstantValue::Float32 { value, .. } => {
                let float_value = f32::from_bits((*value as u32)); // 将解引用后的值转为 u32
                let float_bytes = float_value.to_bits().to_le_bytes().to_vec();
                RawData::Bytes(float_bytes)
            }
            ir::ConstantValue::AggregateZero { .. } => {
                // 如果是零初始化，直接用 BSS 段管理
                RawData::Bss(size)
            }
            ir::ConstantValue::Array { elems, .. } => {
                // 如果是数组，递归处理每个元素
                let mut queue = VecDeque::new();
                let mut bytes = Vec::new();
                if elems.len() == 0 {
                    // 空数组时，直接用 BSS 段管理
                    RawData::Bss(size)
                } else {
                    for elem in elems {
                        queue.push_back(elem.clone());

                        while let Some(elem) = queue.pop_front() {
                            let elem_bytes = match elem {
                                ir::ConstantValue::Int1 { value, .. } => vec![*value as u8],
                                ir::ConstantValue::Int8 { value, .. } => {
                                    value.to_le_bytes().to_vec()
                                }
                                ir::ConstantValue::Int32 { value, .. } => {
                                    value.to_le_bytes().to_vec()
                                }
                                ir::ConstantValue::Float32 { value, .. } => {
                                    let float_value = f32::from_bits((*value as u32));
                                    float_value.to_bits().to_le_bytes().to_vec()
                                }
                                ir::ConstantValue::Array { elems, .. } => {
                                    // TODO: queue.extend(elems.iter().cloned());
                                    continue;
                                }
                                _ => panic!("Unsupported array element: {:?}", elem),
                            };
                            bytes.extend(elem_bytes);
                        }
                    }
                    RawData::Bytes(bytes)
                }
            }
            _ => panic!("Unsupported global variable type: {:?}", init_value),
        };
    }

    /// Generate a store instruction and append it to the current block.
    /// Here we just demonstrate the idea. Bugs may exist. You can
    /// refactor this entirely as your own way.
    pub fn gen_store(&mut self, val: Value, mem_loc: MemLoc) {
        let curr_block = self.curr_block.unwrap();

        // XXX: You might want to encapsulate this check into a function, since it'll be
        // used multiple times.
        let src = match &val.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { value } => {
                // XXX: You also might want to encapsulate this check into a function.
                match value {
                    ir::ConstantValue::Int32 { value, .. } => {
                        if value == &0 {
                            // Use zero register for zero value.
                            regs::zero().into()
                        } else {
                            // Sign-extend the 32-bit value to 64-bit
                            let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            r
                        }
                    }
                    ConstantValue::Undef { .. } => {
                        // We treat undef as zero temporarily.
                        regs::zero().into()
                    }
                    _ => todo!(),
                }
            }
            ir::ValueKind::InstResult { .. } => {
                // XXX: You also might want to encapsulate this check into a function.
                let mopd = self.lowered[&val];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    MOperandKind::Imm(.., imm) => {
                        let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    MOperandKind::Mem(mem) => {
                        let ty = val.ty(self.ctx);
                        let mop = self.gen_load(ty, mem);
                        match mop.kind {
                            MOperandKind::Reg(reg) => reg,
                            _ => todo!(),
                        }
                    }
                    MOperandKind::Undef => regs::zero().into(),
                }
            }
            ir::ValueKind::Param { func, ty, index } => {
                // TODO✔: Handle parameters.
                // 假设前 4 个参数使用寄存器，超过的参数在栈中
                let operand = if *index < 4 {
                    // 使用 a0, a1, a2, a3 寄存器
                    let reg = match index {
                        0 => regs::a0(),
                        1 => regs::a1(),
                        2 => regs::a2(),
                        3 => regs::a3(),
                        _ => unreachable!(),
                    };
                    MOperand {
                        ty: *ty,
                        kind: MOperandKind::Reg(reg.into()),
                    }
                } else {
                    // 超出寄存器的参数存放在栈中
                    let offset = (index - 4) as i64 * 8; // 每个参数按8字节对齐
                    MOperand {
                        ty: *ty,
                        kind: MOperandKind::Mem(MemLoc::Slot { offset }),
                    }
                };

                // 返回操作数
                match operand.kind {
                    MOperandKind::Reg(reg) => reg,
                    _ => todo!(),
                }
            }
        };

        let bitwidth = val.ty(self.ctx).bitwidth(self.ctx);
        // Different store instructions for different bitwidths.
        let op = match bitwidth {
            8 => StoreOp::Sb,
            16 => StoreOp::Sh,
            32 => StoreOp::Sw,
            64 => StoreOp::Sd,
            _ => unreachable!(),
        };

        // s[bhwd] src, loc
        let store = MInst::store(&mut self.mctx, op, src, mem_loc);
        // Append the store instruction to the current block.
        curr_block.push_back(&mut self.mctx, store).unwrap();
    }

    /// Generate a load instruction and append it to the current block.
    /// Here we just demonstrate the idea. Bugs may exist. You can
    /// refactor this entirely as your own way.
    pub fn gen_load(&mut self, ty: Ty, mem_loc: MemLoc) -> MOperand {
        let curr_block = self.curr_block.unwrap();

        let bitwidth = ty.bitwidth(self.ctx);
        let op = match bitwidth {
            8 => LoadOp::Lb,
            16 => LoadOp::Lh,
            32 => LoadOp::Lw,
            64 => LoadOp::Ld,
            _ => unreachable!(),
        };

        // l[bhwd] rd, loc
        let (load, rd) = MInst::load(&mut self.mctx, op, mem_loc);
        curr_block.push_back(&mut self.mctx, load).unwrap();

        MOperand {
            ty,
            kind: MOperandKind::Reg(rd),
        }
    }

    /// Generate an integer binary operation and append it to the current block.
    /// Here we just demonstrate the idea. Bugs may exist. You can
    /// refactor this entirely as your own way.
    pub fn gen_int_binary(&mut self, op: IntBinaryOp, lhs: Value, rhs: Value) -> MOperand {
        let curr_block = self.curr_block.unwrap();

        // TODO: We only handle reg + reg here, you need to handle other cases.
        let lhs_reg = match &lhs.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { .. } => {
                todo!()
            }
            ir::ValueKind::InstResult { .. } => {
                let mopd = self.lowered[&lhs];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    _ => todo!(),
                }
            }
            ir::ValueKind::Param { .. } => {
                todo!()
            }
        };

        let rhs_reg = match &rhs.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { .. } => {
                todo!()
            }
            ir::ValueKind::InstResult { .. } => {
                let mopd = self.lowered[&rhs];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    _ => todo!(),
                }
            }
            ir::ValueKind::Param { .. } => {
                todo!()
            }
        };

        let bitwidth = lhs.ty(self.ctx).bitwidth(self.ctx);

        match op {
            IntBinaryOp::Add => {
                // addw rd, rs1, rs2
                let alu_op = match bitwidth {
                    32 => AluOpRRR::Addw,
                    // TODO: other bitwidths?
                    _ => todo!(),
                };
                let (add, rd) = MInst::alu_rrr(&mut self.mctx, alu_op, lhs_reg, rhs_reg);
                curr_block.push_back(&mut self.mctx, add).unwrap();

                MOperand {
                    ty: lhs.ty(self.ctx),
                    kind: MOperandKind::Reg(rd),
                }
            }
            // TODO: Add more ops.
            _ => todo!(),
        }
    }

    /// Generate a move instruction needed for return value and append it to the
    /// current block. Here we just demonstrate the idea. Bugs may exist.
    /// You can refactor this entirely as your own way.
    pub fn gen_ret_move(&mut self, val: Value) {
        let curr_block = self.curr_block.unwrap();

        // We only handle reg here, you need to handle other cases.
        let src = match &val.try_deref(self.ctx).unwrap().kind {
            ir::ValueKind::Constant { .. } => {
                todo!()
            }
            ir::ValueKind::InstResult { .. } => {
                let mopd = self.lowered[&val];
                match mopd.kind {
                    MOperandKind::Reg(reg) => reg,
                    _ => todo!(),
                }
            }
            ir::ValueKind::Param { .. } => {
                todo!()
            }
        };

        // addi a0, src, 0
        let mv = MInst::raw_alu_rri(
            &mut self.mctx,
            AluOpRRI::Addi,
            regs::a0().into(),
            src,
            Imm12::try_from_i64(0).unwrap(),
        );
        curr_block.push_back(&mut self.mctx, mv).unwrap();

        let ret = MInst::ret(&mut self.mctx);
        curr_block.push_back(&mut self.mctx, ret).unwrap();

        // regs::a0.into()
    }

    // TODO: Add more helper functions.
    /// Generate a getelementptr instruction and append it to the current block.
    ///
    /// base: The base address.
    /// indices: The indices.
    ///
    /// Return the result operand.
    pub fn gen_gep(&mut self, base: &Value, indices: Vec<Value>, bound_ty: &Ty) -> MOperand {
        let curr_block = self.curr_block.unwrap();
        let curr_func = self.curr_func.unwrap();

        // Get the base register.
        let base_loc = self.memloc_from_value(&base);
        let (base_reg, mut offset) = match base_loc {
            MemLoc::RegOffset { base, offset } => (base, offset),
            MemLoc::Slot { offset } => (
                regs::sp().into(),
                offset + curr_func.storage_stack_size(&self.mctx) as i64,
            ),
            MemLoc::Incoming { offset } => (regs::fp().into(), offset),
        };

        // Calculate the offset.
        let mut ty = bound_ty.clone();
        for op in indices {
            let size = (ty.bitwidth(&self.ctx) + 7) / 8;
            if let ValueKind::Constant { value } = &op.try_deref(self.ctx).unwrap().kind {
                let value = match value {
                    ConstantValue::Int32 { value, .. } => *value as i64,
                    ConstantValue::Int8 { value, .. } => *value as i64,
                    ConstantValue::Int1 { value, .. } => *value as i64,
                    _ => todo!(),
                };
                offset -= value * size as i64;
            }
            if let Some((inner_ty, ..)) = ty.as_array(&self.ctx) {
                ty = inner_ty;
            }
        }

        // addi dst, base, offset
        let dst_reg = self.mctx.new_vreg(RegKind::General).into();
        let mv = MInst::raw_alu_rri(
            &mut self.mctx,
            AluOpRRI::Addi,
            dst_reg,
            base_reg,
            Imm12::try_from_i64(offset).unwrap(),
        );
        curr_block.push_back(&mut self.mctx, mv).unwrap();

        MOperand {
            ty,
            kind: MOperandKind::Reg(dst_reg),
        }
    }

    pub fn gen_cond_branch(
        &mut self,
        cond: ir::Value,
        then_block: MBlock,
        else_block: Option<MBlock>,
        end_block: MBlock,
    ) {
        let curr_block = self.curr_block.unwrap();

        let cond_reg = self.reg_from_value(&cond);

        if let Some(else_block) = else_block {
            let bnez = MInst::new(
                &mut self.mctx,
                MInstKind::Branch {
                    op: BranchOp::Bne,
                    rs1: cond_reg,
                    rs2: regs::zero().into(),
                    target: then_block,
                },
            );
            curr_block.push_back(&mut self.mctx, bnez).unwrap();

            let j_else = MInst::j(&mut self.mctx, else_block);
            curr_block.push_back(&mut self.mctx, j_else).unwrap();

            let j_end = MInst::j(&mut self.mctx, end_block);
            then_block.push_back(&mut self.mctx, j_end).unwrap();
        } else {
            let bnez = MInst::new(
                &mut self.mctx,
                MInstKind::Branch {
                    op: BranchOp::Bne,
                    rs1: cond_reg,
                    rs2: regs::zero().into(),
                    target: then_block,
                },
            );
            curr_block.push_back(&mut self.mctx, bnez).unwrap();

            let j_end = MInst::j(&mut self.mctx, end_block);
            then_block.push_back(&mut self.mctx, j_end).unwrap();
        }
    }

    /// Generate a function call instruction and append it to the current block.
    ///
    /// callee_name: The name of the callee function.
    /// args: The arguments of the function call.
    /// ret: The return value of the function call.
    ///
    /// return: The register that stores the return value.
    // pub fn gen_call(
    //     &mut self,
    //     callee_name: &String,
    //     args: Vec<Value>,
    //     ret: Option<Value>,
    // ) -> Option<MOperand> {
    //     let curr_block = self.curr_block.unwrap();

    //     // Prepare arguments.
    //     for (index, arg) in args.iter().enumerate() {
    //         let (arg_reg, arg_imm) = self.reg_or_imm_from_value(&arg);
    //         let mv = if let Some(arg_reg) = arg_reg {
    //             MInst::raw_alu_rri(
    //                 &mut self.mctx,
    //                 AluOpRRI::Addi,
    //                 regs::get_arg(index).into(),
    //                 arg_reg,
    //                 Imm12::try_from_i64(0).unwrap(),
    //             )
    //         } else if let Some(arg_imm) = arg_imm {
    //             MInst::raw_alu_rri(
    //                 &mut self.mctx,
    //                 AluOpRRI::Addi,
    //                 regs::get_arg(index).into(),
    //                 regs::zero().into(),
    //                 arg_imm,
    //             )
    //         } else {
    //             continue;
    //         };
    //         curr_block.push_back(&mut self.mctx, mv).unwrap();
    //     }

    //     // Ensure the callee function exists.
    //     assert!(self.funcs.contains_key(callee_name));

    //     // jal func
    //     let call = MInst::call(&mut self.mctx, MLabel::from(callee_name.clone()));
    //     curr_block.push_back(&mut self.mctx, call).unwrap();

    //     // Handle return value.
    //     if let Some(ret) = ret {
    //         Some(MOperand {
    //             ty: ret.ty(self.ctx),
    //             kind: MOperandKind::Reg(self.gen_ret_move(ret)),
    //         })
    //     } else {
    //         None
    //     }
    // }

    pub fn memloc_from_value(&mut self, val: &Value) -> MemLoc {
        let curr_block = self.curr_block.unwrap();
        let curr_func = self.curr_func.unwrap();
        if let Some(mopd) = self.lowered.get(&val) {
            match mopd.kind {
                MOperandKind::Reg(reg) => MemLoc::RegOffset {
                    base: reg,
                    offset: 0,
                },
                MOperandKind::Imm(..) => todo!(),
                MOperandKind::Undef => MemLoc::RegOffset {
                    base: regs::zero().into(),
                    offset: 0,
                },
                MOperandKind::Mem(loc) => match loc {
                    MemLoc::RegOffset { .. } => loc,
                    MemLoc::Slot { offset } => MemLoc::RegOffset {
                        base: regs::sp().into(),
                        offset: offset + curr_func.storage_stack_size(&self.mctx) as i64,
                    },
                    MemLoc::Incoming { offset } => MemLoc::RegOffset {
                        base: regs::fp().into(),
                        offset,
                    },
                },
            }
        } else {
            match &val.try_deref(self.ctx).unwrap().kind {
                ir::ValueKind::Constant { value } => match value {
                    ir::ConstantValue::GlobalRef { name, .. } => {
                        let (la, rd) = MInst::la(&mut self.mctx, &name);
                        curr_block.push_back(&mut self.mctx, la).unwrap();
                        let loc = MemLoc::RegOffset {
                            base: rd,
                            offset: 0,
                        };
                        self.lowered.insert(
                            val.clone(),
                            MOperand {
                                ty: val.ty(self.ctx),
                                kind: MOperandKind::Mem(loc),
                            },
                        );
                        loc
                    }
                    _ => {
                        eprintln!("Unsupported constant: {:?}", value);
                        unreachable!()
                    }
                },
                _ => todo!(),
            }
        }
    }

    pub fn reg_from_value(&mut self, val: &Value) -> Reg {
        let curr_block = self.curr_block.unwrap();
        let ty = val.ty(self.ctx);
        if let Some(mopd) = self.lowered.get(&val) {
            match mopd.kind {
                MOperandKind::Reg(reg) => reg,
                MOperandKind::Imm(.., imm) => {
                    let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                    curr_block.push_back(&mut self.mctx, li).unwrap();
                    match ty.kind(&self.ctx) {
                        TyData::Int1 | TyData::Int8 | TyData::Int32 => r,
                        _ => todo!(),
                    }
                }
                MOperandKind::Undef => regs::zero().into(),
                MOperandKind::Mem(loc) => {
                    let mop = self.gen_load(val.ty(self.ctx), loc);
                    match mop.kind {
                        MOperandKind::Reg(reg) => reg,
                        _ => todo!(),
                    }
                }
            }
        } else {
            match &val.try_deref(self.ctx).unwrap().kind {
                ir::ValueKind::Constant { value } => match value {
                    ConstantValue::Int32 { value, .. } => {
                        let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    ConstantValue::Int8 { value, .. } => {
                        let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    ConstantValue::Int1 { value, .. } => {
                        let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    ConstantValue::Float32 { value, .. } => {
                        let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    ConstantValue::Undef { .. } => {
                        let (li, r) = MInst::li(&mut self.mctx, 0);
                        curr_block.push_back(&mut self.mctx, li).unwrap();
                        r
                    }
                    _ => {
                        eprintln!("Unsupported constant: {:?}", value);
                        unreachable!()
                    }
                },
                ir::ValueKind::InstResult { .. } | ir::ValueKind::Param { .. } => {
                    let vreg = match ty.kind(&self.ctx) {
                        TyData::Int1 | TyData::Int8 | TyData::Int32 => {
                            self.mctx.new_vreg(RegKind::General)
                        }
                        // TyData::Float32 => self.mctx.new_vreg(RegKind::Float),
                        _ => todo!(),
                    };
                    let reg = vreg.into();
                    self.lowered.insert(
                        val.clone(),
                        MOperand {
                            ty,
                            kind: MOperandKind::Reg(reg),
                        },
                    );
                    reg
                }
                _ => todo!(),
            }
        }
    }

    pub fn reg_or_imm_from_value(&mut self, val: &Value) -> (Option<Reg>, Option<Imm12>) {
        let curr_block = self.curr_block.unwrap();
        let ty = val.ty(self.ctx);
        if let Some(mopd) = self.lowered.get(&val) {
            match mopd.kind {
                MOperandKind::Reg(reg) => (Some(reg), None),
                MOperandKind::Imm(.., imm) => match ty.kind(&self.ctx) {
                    TyData::Int1 | TyData::Int8 | TyData::Int32 => {
                        println!("try from i64: {}", imm);
                        if let Some(imm) = Imm12::try_from_i64(imm) {
                            (None, Some(imm))
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            (Some(r), None)
                        }
                    }
                    // TyData::Float32 => {
                    //     let (li, r) = MInst::li(&mut self.mctx, imm as u64);
                    //     curr_block.push_back(&mut self.mctx, li).unwrap();
                    //     let fs1 = self.mctx.new_vreg(RegKind::Float).into();
                    //     let fmv = MInst::fpu_move(&mut self.mctx, FpuMoveOp::FmvSX, fs1, r);
                    //     curr_block.push_back(&mut self.mctx, fmv).unwrap();
                    //     (Some(fs1), None)
                    // }
                    _ => todo!(),
                },
                MOperandKind::Undef => (Some(regs::zero().into()), None),
                MOperandKind::Mem(loc) => {
                    let mop = self.gen_load(val.ty(self.ctx), loc);
                    match mop.kind {
                        MOperandKind::Reg(reg) => (Some(reg), None),
                        _ => todo!(),
                    }
                }
            }
        } else {
            match &val.try_deref(self.ctx).unwrap().kind {
                ir::ValueKind::Constant { value } => match value {
                    ir::ConstantValue::Int32 { value, .. } => {
                        if let Some(imm) = Imm12::try_from_i64(*value as i64) {
                            (None, Some(imm))
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            (Some(r), None)
                        }
                    }
                    ir::ConstantValue::Int8 { value, .. } => {
                        if let Some(imm) = Imm12::try_from_i64(*value as i64) {
                            (None, Some(imm))
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            (Some(r), None)
                        }
                    }
                    ir::ConstantValue::Int1 { value, .. } => {
                        if let Some(imm) = Imm12::try_from_i64(*value as i64) {
                            (None, Some(imm))
                        } else {
                            let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                            curr_block.push_back(&mut self.mctx, li).unwrap();
                            (Some(r), None)
                        }
                    }
                    // ir::ConstantValue::Float32 { value, .. } => {
                    //     let (li, r) = MInst::li(&mut self.mctx, *value as u64);
                    //     curr_block.push_back(&mut self.mctx, li).unwrap();
                    //     let fs1 = self.mctx.new_vreg(RegKind::Float).into();
                    //     let fmv = MInst::fpu_move(&mut self.mctx, FpuMoveOp::FmvSX, fs1, r);
                    //     curr_block.push_back(&mut self.mctx, fmv).unwrap();
                    //     (Some(fs1), None)
                    // }
                    ir::ConstantValue::Undef { .. } => (Some(regs::zero().into()), None),
                    _ => {
                        eprintln!("Unsupported constant: {:?}", value);
                        unreachable!()
                    }
                },
                ir::ValueKind::InstResult { .. } | ir::ValueKind::Param { .. } => {
                    let vreg = match ty.kind(&self.ctx) {
                        TyData::Int1 | TyData::Int8 | TyData::Int32 => {
                            self.mctx.new_vreg(RegKind::General)
                        }
                        // TyData::Float32 => self.mctx.new_vreg(RegKind::Float),
                        _ => todo!(),
                    };
                    let reg = vreg.into();
                    self.lowered.insert(
                        val.clone(),
                        MOperand {
                            ty,
                            kind: MOperandKind::Reg(reg),
                        },
                    );
                    (Some(reg), None)
                }
                _ => todo!(),
            }
        }
    }
}