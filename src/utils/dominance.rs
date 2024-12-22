// reference: https://github.com/JuniMay/orzcc/blob/master/src/utils/dominance.rs
use std::hash::Hash;
use std::collections::HashMap;

use super::cfg::{CfgNode, CfgRegion, CfgInfo};
use crate::infra::storage::{ArenaPtr};
use crate::infra::linked_list::{LinkedListContainer, LinkedListNode};
use super::dfs::DfsContext;
use crate::ir::Context;

/// 控制流图的支配关系分析信息
pub struct Dominance<N> 
where
    N: CfgNode + std::fmt::Debug
{
    /// 每个节点的直接支配者 
    idoms: HashMap<N, Option<N>>,
    /// 每个节点的支配边界
    frontiers: HashMap<N, Vec<N>>, 
    /// 支配树中每个节点的子节点
    domtree: HashMap<N, Vec<N>>,
    /// 反向后序遍历序列中的节点
    rpo: Vec<N>,
    /// 每个节点的支配层级
    levels: HashMap<N, usize>,
}

impl<N> Default for Dominance<N>
where
    N: CfgNode + std::fmt::Debug
{
    fn default() -> Self {
        Self {
            idoms: HashMap::new(),
            frontiers: HashMap::new(), 
            domtree: HashMap::new(),
            rpo: Vec::new(),
            levels: HashMap::new(),
        }
    }
}

impl<N> Dominance<N>
where
    N: CfgNode + Hash + Eq + std::fmt::Debug
{
    /// 获取节点的直接支配者
    pub fn idom(&self, node: N) -> Option<N> {
        self.idoms.get(&node).copied().flatten()
    }

    /// 获取节点的支配边界
    pub fn frontier(&self, node: N) -> &[N] {
        self.frontiers.get(&node).map(|v| v.as_slice()).unwrap_or(&[])
    }

    /// 获取支配树中节点的子节点
    pub fn children(&self, node: N) -> &[N] {
        self.domtree.get(&node).map(|v| v.as_slice()).unwrap_or(&[])
    }

    /// 获取反向后序遍历序列
    pub fn rpo(&self) -> &[N] {
        &self.rpo
    }

    /// 获取节点的支配层级
    /// 延迟计算 - 首次访问时才计算该节点的层级
    pub fn level(&mut self, node: N) -> usize {
        if let Some(&level) = self.levels.get(&node) {
            return level;
        }
        
        let level = if let Some(idom) = self.idom(node) {
            self.level(idom) + 1
        } else {
            0  // 入口节点层级为0
        };
        
        self.levels.insert(node, level);
        level
    }

    /// 检查 n1 是否支配 n2
    pub fn dominates(&self, n1: N, n2: N) -> bool {
        if n1 == n2 {
            return true;  // 节点支配自己
        }

        let mut current = n2;
        while let Some(idom) = self.idom(current) {
            if idom == n1 {
                return true;
            }
            current = idom;
        }
        false
    }

    /// 辅助函数:在支配树中寻找两个节点的交点
    fn intersect(
        n1: N,
        n2: N, 
        idoms: &HashMap<N, Option<N>>,
        postorder: &HashMap<N, usize>
    ) -> N {
        let mut finger1 = n1;
        let mut finger2 = n2;
        
        while finger1 != finger2 {
            // 按后序编号大小移动指针
            while postorder[&finger1] < postorder[&finger2] {
                finger1 = idoms[&finger1].unwrap();
            }
            while postorder[&finger2] < postorder[&finger1] {
                finger2 = idoms[&finger2].unwrap();
            }
        }
        finger1  // 返回交点
    }

    /// 创建新的支配关系分析
    pub fn new(ctx: &Context, cfg: &CfgInfo<N, N::Region>) -> Self 
    where 
        N::Region: CfgRegion<Node = N>,
    {
        let mut idoms = HashMap::new();
        let mut frontiers = HashMap::new();
        let mut domtree = HashMap::new();
        let mut postorder = HashMap::new();
        let mut rpo = Vec::new();

        let region = cfg.region();
        let mut dfs = DfsContext::default();

        // 收集后序遍历的节点并初始化数据结构
        for (i, node) in dfs.post_order_iter(ctx, region).enumerate() {
            postorder.insert(node, i);
            rpo.push(node);
            idoms.insert(node, None);
            frontiers.insert(node, Vec::new());
            domtree.insert(node, Vec::new());
        }

        // 反转得到反向后序
        rpo.reverse();

        // 入口节点支配自己
        let entry = region.entry_node(ctx);
        assert_eq!(rpo[0], entry);
        idoms.insert(entry, Some(entry));

        // 迭代计算直接支配者
        let mut changed = true;
        while changed {
            changed = false;
            
            for &node in rpo.iter().skip(1) {
                let mut new_idom = None;
                
                // 找到第一个已处理的前驱
                for pred in cfg.preds(node).unwrap() {
                    if idoms[pred].is_some() {
                        new_idom = Some(*pred);
                        break;
                    }
                }

                let mut new_idom = new_idom.expect("没有找到已处理的前驱");

                // 与其他前驱求交
                for &pred in cfg.preds(node).unwrap() {
                    if pred != new_idom && idoms[&pred].is_some() {
                        new_idom = Self::intersect(new_idom, pred, &idoms, &postorder);
                    }
                }

                if idoms[&node] != Some(new_idom) {
                    idoms.insert(node, Some(new_idom));
                    changed = true;
                }
            }
        }

        // 入口节点没有支配者
        idoms.insert(entry, None);

        // 构建支配树
        for (&node, &idom) in idoms.iter() {
            if let Some(idom) = idom {
                domtree.get_mut(&idom).unwrap().push(node);
            }
        }

        // 计算支配边界
        for &node in rpo.iter() {
            if cfg.preds(node).unwrap().len() >= 2 {
                for &pred in cfg.preds(node).unwrap() {
                    let mut runner = pred;
                    while let Some(idom) = idoms[&node] {
                        if runner == idom {
                            break;
                        }
                        frontiers.get_mut(&runner).unwrap().push(node);
                        runner = idoms[&runner].unwrap();
                    }
                }
            }
        }

        Self {
            idoms,
            frontiers,
            domtree,
            rpo,
            levels: HashMap::new(),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::{Block, Func, Value, Inst, Ty};

    fn create_test_cfg(ctx: &mut Context) -> (Func, CfgInfo<Block, Func>) {
        // 创建测试函数,包含循环结构
        let ret_ty = Ty::void(ctx);
        let func = Func::new(ctx, "test_func".to_string(), ret_ty);
        
        // 创建基本块
        let entry = Block::new(ctx);
        let loop_header = Block::new(ctx);
        let loop_body = Block::new(ctx);
        let loop_tail = Block::new(ctx);
        let exit = Block::new(ctx);

        // 将基本块添加到函数中
        func.push_back(ctx, entry).unwrap();
        func.push_back(ctx, loop_header).unwrap();
        func.push_back(ctx, loop_body).unwrap();
        func.push_back(ctx, loop_tail).unwrap();
        func.push_back(ctx, exit).unwrap();

        // 创建分支指令
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

        let cfg = CfgInfo::new(ctx, func);
        
        (func, cfg)
    }

    #[test]
    fn test_dominance() {
        let mut ctx = Context::new(8);
        let (func, cfg) = create_test_cfg(&mut ctx);
        
        let dom = Dominance::new(&ctx, &cfg);

        // 测试直接支配者
        let entry = func.entry_node(&ctx);
        assert!(dom.idom(entry).is_none());

        // 测试支配边界
        for block in func.iter(&ctx) {
            println!("Block {} frontiers:", block.name(&ctx));
            for frontier in dom.frontier(block) {
                println!("  {}", frontier.name(&ctx));
            }
        }

        // Test dominance tree
        for block in func.iter(&ctx) {
            println!("Block {} children:", block.name(&ctx));
            for child in dom.children(block) {
                println!("  {}", child.name(&ctx));
            }
        }
    }
}