use std::collections::{HashMap, HashSet}; 
use crate::infra::storage::{ArenaPtr, Idx};
use crate::infra::linked_list::{LinkedListContainer, LinkedListNode};
use crate::ir::{Context, Block, Func, Inst};

/// A node in a control flow graph.
pub trait CfgNode: ArenaPtr {
    /// The region type associated with the node.
    type Region: CfgRegion<Node = Self>;

    /// Get the successors of the node.
    fn succs(self, ctx: &Context) -> Vec<Self>;
}

/// A region that contains control flow graph information.
pub trait CfgRegion: ArenaPtr<Arena = Context> {
    /// The node type associated with the region.
    type Node: CfgNode<Region = Self>;

    /// Get the entry node of the region.
    fn entry_node(self, ctx: &Context) -> Self::Node;
}

/// Control flow graph information.
pub struct CfgInfo<N, R>
where
    N: CfgNode,
    R: CfgRegion<Node = N>,  
{
    /// The region associated with the CFG.
    region: R,
    /// Successors of each node.
    succs: HashMap<N, Vec<N>>,
    /// Predecessors of each node.
    preds: HashMap<N, Vec<N>>,
}

impl<N, R> CfgInfo<N, R> 
where
    N: CfgNode + std::hash::Hash + Eq,
    R: CfgRegion<Node = N>,
{
    /// Build CFG information from region.
    pub fn new(ctx: &Context, region: R) -> Self {
        let mut succs: HashMap<N, Vec<N>> = HashMap::new();
        let mut preds: HashMap<N, Vec<N>> = HashMap::new();
    
        let entry = region.entry_node(ctx);
        let mut worklist = vec![entry];
        let mut visited = HashSet::new();
    
        while let Some(node) = worklist.pop() {
            if visited.contains(&node) {
                continue;
            }
            visited.insert(node);
    
            // Create entries for reachable nodes
            succs.entry(node).or_default();
            preds.entry(node).or_default(); 
    
            for succ in node.succs(ctx) {
                succs.entry(node).or_default().push(succ);
                preds.entry(succ).or_default().push(node);
                worklist.push(succ);
            }
        }
    
        Self {
            region,
            succs,
            preds,
        }
    }

    /// Get successors of a node. 
    pub fn succs(&self, node: N) -> Option<&[N]> {
        self.succs.get(&node).map(|v| v.as_slice())
    }

    /// Get predecessors of a node.
    pub fn preds(&self, node: N) -> Option<&[N]> {
        self.preds.get(&node).map(|v| v.as_slice())
    }

    /// Get the region.
    pub fn region(&self) -> R {
        self.region
    }

    /// Get reachable nodes.
    pub fn reachable_nodes(&self, ctx: &Context) -> HashSet<N> {
        let mut reachables = HashSet::new();
        let entry = self.region.entry_node(ctx);
        
        let mut worklist = vec![entry];
        while let Some(node) = worklist.pop() {
            if !reachables.insert(node) {
                continue;
            }

            if let Some(succs) = self.succs(node) {
                worklist.extend_from_slice(succs);
            }
        }

        reachables
    }
}

impl CfgNode for Block {
    type Region = Func;

    fn succs(self, ctx: &Context) -> Vec<Block> {
        // 获取基本块的最后一条指令
        if let Some(term) = self.tail(ctx) {
            // 如果是终结指令，获取其后继块
            if term.is_terminator(ctx) {
                // 使用 successor_iter 收集所有后继基本块
                term.successor_iter(ctx).collect()
            } else {
                // 如果不是终结指令，检查是否有下一个基本块
                if let Some(next_block) = self.next(ctx) {
                    vec![next_block]
                } else {
                    Vec::new()
                }
            }
        } else {
            // 如果没有指令，检查是否有下一个基本块
            if let Some(next_block) = self.next(ctx) {
                vec![next_block]
            } else {
                Vec::new()
            }
        }
    }
}

impl CfgRegion for Func {
    type Node = Block;

    fn entry_node(self, ctx: &Context) -> Block {
        self.head(ctx).expect("function must have entry block")
    }
}

impl CfgInfo<Block, Func> {
    // 原有的 to_dot 方法保持不变
    pub fn to_dot(&self, ctx: &Context) -> String {
        let mut dot = String::from("digraph CFG {\n");
        
        // 添加所有节点
        let reachable = self.reachable_nodes(ctx);
        for node in reachable.clone() {
            let mut label = format!("{}:\\l", node.name(ctx));
            for inst in node.iter(ctx) {
                label.push_str(&format!("    {}\\l", inst.display(ctx)));
            }
            
            dot.push_str(&format!(
                "    \"{}\" [shape=box,label=\"{}\"];\n", 
                node.name(ctx),
                label
            ));
        }
        
        // 添加所有边
        for node in reachable {
            if let Some(succs) = self.succs(node) {
                for succ in succs {
                    dot.push_str(&format!("    \"{}\" -> \"{}\";\n",
                        node.name(ctx),
                        succ.name(ctx)));
                }
            }
        }
        
        dot.push_str("}\n");
        dot
    }

    // 新增方法：将多个函数的 CFG 合并到一个图中
    pub fn combine_cfgs(cfgs: &[(Func, CfgInfo<Block, Func>)], ctx: &Context) -> String {
        let mut dot = String::from("digraph CFG {\n");
        
        // 为每个函数创建一个子图
        for (func, cfg) in cfgs {
            dot.push_str(&format!("    subgraph cluster_{} {{\n", func.name(ctx)));
            dot.push_str(&format!("        label=\"{}\";\n", func.name(ctx)));
            
            // 添加该函数的所有节点
            let reachable = cfg.reachable_nodes(ctx);
            for node in reachable.clone() {
                let mut label = format!("{}:\\l", node.name(ctx));
                for inst in node.iter(ctx) {
                    label.push_str(&format!("    {}\\l", inst.display(ctx)));
                }
                
                dot.push_str(&format!(
                    "        \"{}\" [shape=box,label=\"{}\"];\n", 
                    node.name(ctx),
                    label
                ));
            }
            
            // 添加该函数内的边
            for node in reachable {
                if let Some(succs) = cfg.succs(node) {
                    for succ in succs {
                        dot.push_str(&format!("        \"{}\" -> \"{}\";\n",
                            node.name(ctx),
                            succ.name(ctx)));
                    }
                }
            }
            
            dot.push_str("    }\n");
        }
        
        dot.push_str("}\n");
        dot
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::{Value, Ty};

    fn create_test_cfg(ctx: &mut Context) -> (Func, CfgInfo<Block, Func>) {
        // 创建一个简单的函数，包含以下基本块结构：
        //
        // entry
        //   |
        //   v
        // loop_header
        //   |     \
        // loop_body \
        //   |        \
        //   v         v
        // loop_tail  exit

        // 创建函数
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

        // 创建条件值（用于条件跳转）
        let cond = Value::i1(ctx, true);

        // 创建跳转指令
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

        // 创建 CFG
        let cfg = CfgInfo::new(ctx, func);

        (func, cfg)
    }

    #[test]
    fn test_cfg_successors() {
        let mut ctx = Context::new(8);
        let (func, cfg) = create_test_cfg(&mut ctx);

        // 获取所有基本块
        let mut blocks: Vec<_> = func.iter(&ctx).collect();
        assert_eq!(blocks.len(), 5);

        let [entry, loop_header, loop_body, loop_tail, exit] = blocks.as_slice() else {
            panic!("Unexpected number of blocks");
        };

        // 测试后继关系
        assert_eq!(cfg.succs(*entry).unwrap(), &[*loop_header]);
        assert_eq!(cfg.succs(*loop_header).unwrap().len(), 2);
        assert!(cfg.succs(*loop_header).unwrap().contains(loop_body));
        assert!(cfg.succs(*loop_header).unwrap().contains(exit));
        assert_eq!(cfg.succs(*loop_body).unwrap(), &[*loop_tail]);
        assert_eq!(cfg.succs(*loop_tail).unwrap(), &[*loop_header]);
        assert_eq!(cfg.succs(*exit).unwrap(), &[]);
    }

    #[test]
    fn test_cfg_predecessors() {
        let mut ctx = Context::new(8);
        let (func, cfg) = create_test_cfg(&mut ctx);

        let mut blocks: Vec<_> = func.iter(&ctx).collect();
        let [entry, loop_header, loop_body, loop_tail, exit] = blocks.as_slice() else {
            panic!("Unexpected number of blocks");
        };

        // 测试前驱关系
        assert_eq!(cfg.preds(*entry).unwrap(), &[]);
        assert_eq!(cfg.preds(*loop_header).unwrap().len(), 2);
        assert!(cfg.preds(*loop_header).unwrap().contains(entry));
        assert!(cfg.preds(*loop_header).unwrap().contains(loop_tail));
        assert_eq!(cfg.preds(*loop_body).unwrap(), &[*loop_header]);
        assert_eq!(cfg.preds(*loop_tail).unwrap(), &[*loop_body]);
        assert_eq!(cfg.preds(*exit).unwrap(), &[*loop_header]);
    }

    #[test]
    fn test_cfg_reachable_nodes() {
        let mut ctx = Context::new(8);
        let (_, cfg) = create_test_cfg(&mut ctx);

        let reachable = cfg.reachable_nodes(&ctx);
        assert_eq!(reachable.len(), 5); // 所有块都应该可达
    }

    #[test]
    fn test_cfg_dot() {
        let mut ctx = Context::new(8);
        let (_, cfg) = create_test_cfg(&mut ctx);
        
        let dot = cfg.to_dot(&ctx);
        std::fs::write("cfg.dot", dot).unwrap();
    }
}