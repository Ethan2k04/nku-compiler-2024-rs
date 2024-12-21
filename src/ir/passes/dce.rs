use std::collections::HashSet;
use crate::ir::{Context, Func, Block, FuncKind, Inst, Value};
use crate::ir::def_use::Usable;
use crate::utils::cfg::CfgInfo;
use crate::utils::dfs::DfsContext;
use crate::infra::linked_list::{LinkedListContainer, LinkedListNode};

#[derive(Debug)]
pub enum DeadCodeEliminationError {
    /// 当尝试删除一个仍在使用的值时报错
    ValueStillInUse(Value),
}

pub struct UnreachableCodeElimination;

impl UnreachableCodeElimination {
    /// 删除终结指令后的所有指令
    fn eliminate_dead_code_after_terminator(
        &mut self,
        ctx: &mut Context,
        func: Func,
    ) -> Result<bool, DeadCodeEliminationError> {
        let mut changed = false;
        let mut insts_to_remove = Vec::new();

        // 收集要删除的指令
        for block in func.iter(ctx) {
            let mut has_terminator = false;
            for inst in block.iter(ctx) {
                if has_terminator {
                    insts_to_remove.push(inst);
                } else if inst.is_terminator(ctx) {
                    has_terminator = true;
                }
            }
        }

        // 从后向前删除指令，以确保正确处理def-use关系
        for inst in insts_to_remove.into_iter().rev() {
            // 检查指令的结果是否还在使用
            if let Some(result) = inst.result(ctx) {
                // 将users收集到Vec中再检查
                let users: Vec<_> = result.users(ctx).into_iter().collect();
                if !users.is_empty() {
                    return Err(DeadCodeEliminationError::ValueStillInUse(result));
                }
            }

            // 删除指令
            inst.unlink(ctx);
            changed = true;
        }

        Ok(changed)
    }

    /// 删除不可达的基本块
    fn eliminate_unreachable_blocks(&mut self, ctx: &mut Context, func: Func) -> bool {
        let mut changed = false;

        // 构建CFG并获取可达块集合
        let cfg = CfgInfo::new(ctx, func);
        let reachable = cfg.reachable_nodes(ctx);

        // 收集要删除的基本块和指令
        let mut blocks_to_remove = Vec::new();
        let mut insts_to_remove = Vec::new();

        for block in func.iter(ctx) {
            if !reachable.contains(&block) {
                // 收集块中的所有指令
                for inst in block.iter(ctx) {
                    insts_to_remove.push(inst);
                }
                blocks_to_remove.push(block);
            }
        }

        // 先删除所有不可达块中的指令
        for inst in insts_to_remove.into_iter().rev() {
            // 删除与该指令相关的所有def-use关系
            if let Some(result) = inst.result(ctx) {
                let users: Vec<_> = result.users(ctx).into_iter().collect();
                for user in users {
                    result.remove_user(ctx, user);
                }
            }

            // 如果是分支指令，处理其successors
            for succ in inst.successor_iter(ctx).collect::<Vec<_>>() {
                // 这里可以添加额外的清理工作，比如更新phi节点等
            }

            inst.unlink(ctx);
            changed = true;
        }

        // 再删除不可达块
        for block in blocks_to_remove {
            block.unlink(ctx);
            changed = true;
        }

        changed
    }

    /// 在整个函数上运行死代码删除
    pub fn eliminate_dead_code(
        &mut self,
        ctx: &mut Context,
        func: Func,
    ) -> Result<bool, DeadCodeEliminationError> {
        match func.kind(ctx) {
            FuncKind::Define => {
                let mut changed = false;

                // 先删除终结指令后的代码
                changed |= self.eliminate_dead_code_after_terminator(ctx, func)?;

                // 再删除不可达块
                changed |= self.eliminate_unreachable_blocks(ctx, func);

                Ok(changed)
            }
            FuncKind::Declare => Ok(false),
        }
    }

    /// 在整个模块上运行死代码删除
    pub fn run_on_module(&mut self, ctx: &mut Context) -> Result<bool, DeadCodeEliminationError> {
        let mut changed = false;
        
        // 收集所有函数
        let funcs: Vec<_> = ctx.funcs().collect();
        
        // 对每个函数运行优化
        for func in funcs {
            changed |= self.eliminate_dead_code(ctx, func)?;
        }

        Ok(changed)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::{Ty};

    #[test]
    fn test_eliminate_dead_code_after_terminator() {
        let mut ctx = Context::new(8);
        let ret_ty = Ty::void(&mut ctx);
        let func = Func::new(&mut ctx, "test".to_string(), ret_ty);

        // 创建一个基本块，其中包含终结指令后的死代码
        let block = Block::new(&mut ctx);
        func.push_back(&mut ctx, block).unwrap();

        // 添加一个return指令和一些死代码
        let ret = Inst::ret(&mut ctx, None);
        block.push_back(&mut ctx, ret).unwrap();

        let dead_inst = Inst::ret(&mut ctx, None); // 这是死代码
        block.push_back(&mut ctx, dead_inst).unwrap();

        // 运行优化
        let mut pass = UnreachableCodeElimination;
        let result = pass.eliminate_dead_code(&mut ctx, func);
        assert!(result.is_ok());
        assert!(result.unwrap());

        // 验证死代码已被删除
        let insts: Vec<_> = block.iter(&ctx).collect();
        assert_eq!(insts.len(), 1);
        assert!(insts[0].is_terminator(&ctx));
    }

    #[test]
    fn test_eliminate_unreachable_blocks() {
        // 使用之前的测试用例，但添加更多验证
        let mut ctx = Context::new(8);
        let ret_ty = Ty::void(&mut ctx);
        let func = Func::new(&mut ctx, "test".to_string(), ret_ty);

        // 创建基本块
        let entry = Block::new(&mut ctx);
        let reachable = Block::new(&mut ctx);
        let unreachable = Block::new(&mut ctx);

        // 添加到函数
        func.push_back(&mut ctx, entry).unwrap();
        func.push_back(&mut ctx, reachable).unwrap();
        func.push_back(&mut ctx, unreachable).unwrap();

        // 创建跳转让unreachable块不可达
        let br = Inst::br(&mut ctx, reachable);
        entry.push_back(&mut ctx, br).unwrap();

        let ret = Inst::ret(&mut ctx, None);
        reachable.push_back(&mut ctx, ret).unwrap();

        // 运行优化
        let mut pass = UnreachableCodeElimination;
        let result = pass.eliminate_dead_code(&mut ctx, func);
        assert!(result.is_ok());
        assert!(result.unwrap());

        // 验证不可达块被删除
        let blocks: Vec<_> = func.iter(&ctx).collect();
        assert_eq!(blocks.len(), 2);

        // 验证CFG
        let cfg = CfgInfo::new(&ctx, func);
        let reachable = cfg.reachable_nodes(&ctx);
        assert_eq!(reachable.len(), 2);
    }
}