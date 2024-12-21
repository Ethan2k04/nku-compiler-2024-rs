//! # Depth-First Search on Control Flow Graph

use std::hash::Hash;
use std::collections::HashSet;

use super::cfg::{CfgNode, CfgRegion};
use crate::infra::storage::{ArenaPtr};
use crate::infra::linked_list::{LinkedListContainer, LinkedListNode};
use crate::ir::{Context, Inst};

/// DFS遍历事件类型
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Event {
    /// 进入节点
    Enter,
    /// 离开节点
    Leave,
}

/// DFS上下文
pub struct DfsContext<N>
where
    N: CfgNode,
{
    /// 存储(Event, Node)对的栈
    stack: Vec<(Event, N)>,
    /// 记录已访问的节点
    visited: HashSet<N>,
}

impl<N> Default for DfsContext<N>
where
    N: CfgNode,
{
    fn default() -> Self {
        Self {
            stack: Vec::new(),
            visited: HashSet::new(),
        }
    }
}

impl<N> DfsContext<N>
where
    N: CfgNode + Hash + Eq,
{
    /// 创建新的DFS迭代器
    pub fn iter<'a>(&'a mut self, ctx: &'a Context, region: N::Region) -> DfsIterator<'a, N> {
        self.stack.clear();
        self.visited.clear();
        let entry = region.entry_node(ctx);
        self.stack.push((Event::Enter, entry));
        DfsIterator { ctx, dfs: self }
    }

    /// 创建先序遍历迭代器
    pub fn pre_order_iter<'a>(
        &'a mut self,
        ctx: &'a Context,
        region: N::Region,
    ) -> DfsPreOrderIterator<'a, N> {
        DfsPreOrderIterator(self.iter(ctx, region))
    }

    /// 创建后序遍历迭代器
    pub fn post_order_iter<'a>(
        &'a mut self,
        ctx: &'a Context,
        region: N::Region,
    ) -> DfsPostOrderIterator<'a, N> {
        DfsPostOrderIterator(self.iter(ctx, region))
    }
}

/// DFS迭代器
pub struct DfsIterator<'a, N>
where
    N: CfgNode,
{
    ctx: &'a Context,
    dfs: &'a mut DfsContext<N>,
}

impl<'a, N> Iterator for DfsIterator<'a, N>
where
    N: CfgNode + Hash + Eq,
{
    type Item = (Event, N);

    fn next(&mut self) -> Option<Self::Item> {
        let mut event_node = None;

        // 弹出栈顶元素直到找到未访问的节点或Leave事件
        while let Some((event, node)) = self.dfs.stack.pop() {
            if event == Event::Enter && self.dfs.visited.contains(&node) {
                continue;
            }
            event_node = Some((event, node));
            break;
        }

        let (event, node) = event_node?;

        if event == Event::Enter && self.dfs.visited.insert(node) {
            // 对于新访问的节点,先压入Leave事件
            self.dfs.stack.push((Event::Leave, node));

            // 获取后继节点
            let succs = node.succs(self.ctx);

            // 将未访问的后继节点压入栈中
            self.dfs.stack.extend(
                succs.into_iter()
                    .rev() // 反转顺序以优先访问第一个后继
                    .filter(|succ| !self.dfs.visited.contains(succ))
                    .map(|succ| (Event::Enter, succ)),
            );
        }

        Some((event, node))
    }
}

/// 先序遍历迭代器
pub struct DfsPreOrderIterator<'a, N>(DfsIterator<'a, N>)
where
    N: CfgNode;

impl<'a, N> Iterator for DfsPreOrderIterator<'a, N>
where
    N: CfgNode + Hash + Eq,
{
    type Item = N;

    fn next(&mut self) -> Option<Self::Item> {
        loop {
            match self.0.next()? {
                (Event::Enter, node) => return Some(node),
                (Event::Leave, _) => continue,
            }
        }
    }
}

/// 后序遍历迭代器
pub struct DfsPostOrderIterator<'a, N>(DfsIterator<'a, N>)
where
    N: CfgNode;

impl<'a, N> Iterator for DfsPostOrderIterator<'a, N>
where
    N: CfgNode + Hash + Eq,
{
    type Item = N;

    fn next(&mut self) -> Option<Self::Item> {
        loop {
            match self.0.next()? {
                (Event::Leave, node) => return Some(node),
                (Event::Enter, _) => continue,
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::{Block, Func, Ty, Value};
    use crate::utils::cfg::CfgInfo;

    fn create_test_cfg(ctx: &mut Context) -> Func {
        // 创建一个简单的函数，包含循环结构
        let ret_ty = Ty::void(ctx);
        let func = Func::new(ctx, "test_func".to_string(), ret_ty);
        
        // 创建基本块
        let entry = Block::new(ctx);
        let loop_header = Block::new(ctx);
        let loop_body = Block::new(ctx);
        let loop_tail = Block::new(ctx);
        let exit = Block::new(ctx);
        // let unreach_block = Block::new(ctx);

        // 将基本块添加到函数中
        func.push_back(ctx, entry).unwrap();
        func.push_back(ctx, loop_header).unwrap();
        func.push_back(ctx, loop_body).unwrap();
        func.push_back(ctx, loop_tail).unwrap();
        func.push_back(ctx, exit).unwrap();
        // func.push_back(ctx, unreach_block).unwrap();

        // 创建条件值和跳转指令
        let cond = Value::i1(ctx, true);
        
        let br1 = Inst::br(ctx, loop_header);
        entry.push_back(ctx, br1).unwrap();

        let br2 = Inst::cond_br(ctx, cond, loop_body, exit);
        loop_header.push_back(ctx, br2).unwrap();

        let br3 = Inst::br(ctx, loop_tail);
        loop_body.push_back(ctx, br3).unwrap();

        let br4 = Inst::br(ctx, loop_header);
        loop_tail.push_back(ctx, br4).unwrap();

        let ret = Inst::ret(ctx, None);
        exit.push_back(ctx, ret).unwrap();

        func
    }

    #[test]
    fn test_dfs() {
        let mut ctx = Context::new(8);
        let func = create_test_cfg(&mut ctx);
        let mut dfs = DfsContext::<Block>::default();
        
        // 测试先序遍历
        let pre_order: Vec<_> = dfs.pre_order_iter(&ctx, func).collect();
        assert!(!pre_order.is_empty());

        // 测试后序遍历
        let post_order: Vec<_> = dfs.post_order_iter(&ctx, func).collect();
        assert!(!post_order.is_empty());
        
        // 验证遍历的节点数量是否正确
        assert_eq!(pre_order.len(), 5);
        assert_eq!(post_order.len(), 5);

        println!("Pre-order traversal:");
        for block in pre_order {
            println!("  {}", block.name(&ctx));
        }

        println!("Post-order traversal:");
        for block in post_order {
            println!("  {}", block.name(&ctx));
        }
    }
}