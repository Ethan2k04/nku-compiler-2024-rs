//! 简化版 Mem2Reg Pass
//! 只处理定义和使用在同一基本块内的情况

use std::collections::HashMap;
use crate::ir::{Context, Func, FuncKind, Inst, InstKind, Value, Ty, Block};
use crate::ir::def_use::Usable;
use crate::infra::linked_list::{LinkedListContainer, LinkedListNode};

pub struct SimpleMem2Reg;

impl SimpleMem2Reg {
    /// 检查是否可以提升为寄存器
    /// 只有当所有 load/store 都在同一基本块时才可以提升
    fn is_promotable(&self, ctx: &Context, alloca: Value) -> Option<(Block, Ty)> {
        // 获取所有使用该 alloca 的指令
        let users: Vec<_> = alloca.users(ctx).into_iter().collect();
        if users.is_empty() {
            return None;
        }

        // 获取第一条使用指令所在的基本块
        let first_block = users[0].inst().container(ctx)?;
        let mut ty = None;

        // 检查所有使用是否都在同一基本块中
        // 同时检查使用类型是否都一致
        for user in &users {
            let inst = user.inst();
            
            // 检查基本块
            if inst.container(ctx) != Some(first_block) {
                return None;
            }

            // 检查指令类型
            match inst.kind(ctx) {
                InstKind::Load => {
                    let result_ty = inst.result(ctx).unwrap().ty(ctx);
                    if ty.is_none() {
                        ty = Some(result_ty);
                    } else if ty != Some(result_ty) {
                        return None;
                    }
                }
                InstKind::Store => {
                    let val = inst.operand(ctx, 0);
                    let val_ty = val.ty(ctx);
                    if ty.is_none() {
                        ty = Some(val_ty);  
                    } else if ty != Some(val_ty) {
                        return None;
                    }
                }
                _ => return None
            }
        }

        ty.map(|t| (first_block, t))
    }

    fn promote_in_block(&self, ctx: &mut Context, alloca: Value, block: Block) -> bool {
        let mut changed = false;
        let mut latest_def = None;
        let mut insts_to_remove = Vec::new();
        let mut replacements = Vec::new(); // 存储需要替换的信息
    
        // 第一遍:收集信息
        for inst in block.iter(ctx) {
            match inst.kind(ctx) {
                InstKind::Store => {
                    let val = inst.operand(ctx, 0);
                    let ptr = inst.operand(ctx, 1);
                    if ptr == alloca {
                        latest_def = Some(val);
                        insts_to_remove.push(inst);
                        changed = true;
                    }
                }
                InstKind::Load => {
                    let ptr = inst.operand(ctx, 0);
                    if ptr == alloca {
                        if let Some(def) = latest_def {
                            let result = inst.result(ctx).unwrap();
                            // 收集需要替换的信息
                            let users: Vec<_> = result.users(ctx).into_iter().collect();
                            for user in users {
                                replacements.push((user.inst(), result, def));
                            }
                            insts_to_remove.push(inst);
                            changed = true;
                        } else {
                            // 如果没有最新的定义，说明这是一个未初始化的读取
                            return false;
                        }
                    }
                }
                _ => {}
            }
        }
    
        // 第二遍:执行替换
        for (inst, old_val, new_val) in replacements {
            inst.replace_operand(ctx, old_val, new_val);
        }
    
        // 第三遍:删除指令
        for inst in insts_to_remove.iter().rev() {  // 反向删除以避免影响索引
            inst.unlink(ctx);
        }
    
        changed
    }

    /// 在整个函数上运行优化
    pub fn run_on_func(&mut self, ctx: &mut Context, func: Func) -> bool {
        match func.kind(ctx) {
            FuncKind::Define => {
                let mut changed = false;
                let mut alloca_insts = Vec::new();

                // 收集所有的 alloca 指令
                for block in func.iter(ctx) {
                    for inst in block.iter(ctx) {
                        if let InstKind::Alloca { .. } = inst.kind(ctx) {
                            alloca_insts.push(inst);
                        }
                    }
                }

                // 对每个 alloca 尝试提升
                for alloca_inst in alloca_insts {
                    let alloca_val = alloca_inst.result(ctx).unwrap();
                    if let Some((block, _)) = self.is_promotable(ctx, alloca_val) {
                        if self.promote_in_block(ctx, alloca_val, block) {
                            alloca_inst.unlink(ctx);
                            changed = true;
                        }
                    }
                }

                changed
            }
            FuncKind::Declare => false, 
        }
    }

    /// 在整个模块上运行优化
    pub fn run(&mut self, ctx: &mut Context) -> bool {
        let mut changed = false;
        
        // 收集所有函数
        let funcs: Vec<_> = ctx.funcs().collect();
        
        // 对每个函数运行优化
        for func in funcs {
            changed |= self.run_on_func(ctx, func);
        }

        changed
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::{Block, Value};

    #[test]
    fn test_mem2reg_simple() {
        let mut ctx = Context::new(8);
        
        // 创建测试函数
        let ret_ty = Ty::void(&mut ctx);
        let func = Func::new(&mut ctx, "test".to_string(), ret_ty);
        let block = Block::new(&mut ctx);
        func.push_back(&mut ctx, block).unwrap();

        // 创建 alloca 指令
        let i32_ty = Ty::i32(&mut ctx);
        let alloca = Inst::alloca(&mut ctx, i32_ty);
        block.push_back(&mut ctx, alloca).unwrap();
        
        // 创建 store 指令
        let val = Value::i32(&mut ctx, 42);
        let alloca_val = alloca.result(&mut ctx).unwrap();
        let store = Inst::store(&mut ctx, val, alloca_val);
        block.push_back(&mut ctx, store).unwrap();

        // 创建 load 指令
        let alloca_val = alloca.result(&mut ctx).unwrap();  
        let load = Inst::load(&mut ctx, alloca_val, i32_ty);
        block.push_back(&mut ctx, load).unwrap();
        
        // 创建返回指令
        let load_result = load.result(&mut ctx).unwrap();
        let ret = Inst::ret(&mut ctx, Some(load_result));
        block.push_back(&mut ctx, ret).unwrap();

        // 运行优化
        let mut pass = SimpleMem2Reg;
        let changed = pass.run(&mut ctx);
        
        assert!(changed);

        // 验证结果
        let insts: Vec<_> = block.iter(&ctx).collect();
        assert_eq!(insts.len(), 1); // 应该只剩下返回指令
        assert!(matches!(insts[0].kind(&ctx), InstKind::Ret));
    }
}