use std::path::Path;
use std::process::Command as SysCommand;

use clap::{Arg, ArgMatches, Command};
use compiler_in_rust::frontend::{irgen, preprocess, SysYParser};
use compiler_in_rust::ir::{FuncKind, Block, Func};
use compiler_in_rust::utils::cfg::CfgInfo;
use compiler_in_rust::utils::dfs::{DfsContext};
use compiler_in_rust::infra::storage::{ArenaPtr, Idx};
use compiler_in_rust::infra::linked_list::{LinkedListContainer, LinkedListNode};
use compiler_in_rust::ir::passes::dce;

fn parse_arguments() -> ArgMatches {
    Command::new("nkucc")
        .arg(
            Arg::new("output")
                .short('o')
                .required(true)
                .help("The output assembly"),
        )
        .arg(Arg::new("source").required(true).help("The source code"))
        .arg(
            Arg::new("s_flag")
                .short('S')
                .action(clap::ArgAction::Count)
                .help("Output an assembly file"),
        )
        .arg(
            Arg::new("opt")
                .short('O')
                .help("Optimization level")
                .default_value("0"),
        )
        .arg(
            Arg::new("emit-ast")
                .long("emit-ast")
                .help("Emit the AST to the specified file"),
        )
        .arg(
            Arg::new("emit-llvm-ir")
                .long("emit-llvm-ir")
                .help("Emit the IR to the specified file"),
        )
        .get_matches()
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("Hello, NKUCC!");

    let matches = parse_arguments();

    // Extract arguments
    let output = matches.get_one::<String>("output");
    let emit_llvm_ir = matches.get_one::<String>("emit-llvm-ir");
    let opt_level = matches.get_one::<String>("opt").unwrap();
    let source = matches.get_one::<String>("source").unwrap();
    let emit_assembly = matches.get_count("s_flag") > 0;

    // Validate source file
    let src = std::fs::read_to_string(source)?;

    let src = preprocess(&src);

    let mut ast = SysYParser::new().parse(&src).unwrap();

    // println!("{:#?}", ast);

    ast.type_check();

    println!("{:#?}", ast);

    let mut ctx = irgen(&ast, 8);


    // 打印优化前的 IR
    // println!("\nIR before optimization:");
    // println!("{}", ctx.to_string());

    // 为每个函数生成优化前的CFG图
    // for func in ctx.funcs() {
    //     if matches!(func.kind(&ctx), FuncKind::Define) {
    //         let cfg = CfgInfo::new(&ctx, func);
    //         let dot = cfg.to_dot(&ctx);
    //         let filename = format!("cfg_before_opt_{}.dot", func.name(&ctx));
    //         std::fs::write(&filename, dot)?;
    //         println!("Generated CFG before optimization: {}", filename);
    //     }
    // }

    // 运行死代码删除优化
    let mut dce_pass = dce::UnreachableCodeElimination;
    match dce_pass.run_on_module(&mut ctx) {
        Ok(changed) => {
            if changed {
                println!("\nDead code elimination made changes to the IR!");
            } else {
                println!("\nNo dead code was found.");
            }
        }
        Err(e) => {
            println!("\nError during dead code elimination: {:?}", e);
        }
    }

    // 打印优化后的 IR
    // println!("\nIR after optimization:");
    // println!("{}", ctx.to_string());

    // // 为每个函数生成优化后的CFG图
    // for func in ctx.funcs() {
    //     if matches!(func.kind(&ctx), FuncKind::Define) {
    //         // 打印函数的基本信息
    //         println!("\nFunction: {}", func.name(&ctx));
            
    //         // 打印基本块信息
    //         println!("Basic blocks after optimization:");
    //         for block in func.iter(&ctx) {
    //             println!("\nBlock: {}", block.name(&ctx));
    //             for inst in block.iter(&ctx) {
    //                 println!("  {}", inst.display(&ctx));
    //             }
    //         }

    //         // 生成优化后的CFG图
    //         let cfg = CfgInfo::new(&ctx, func);
    //         let dot = cfg.to_dot(&ctx);
    //         let filename = format!("cfg_after_opt_{}.dot", func.name(&ctx));
    //         std::fs::write(&filename, dot)?;
    //         println!("Generated CFG after optimization: {}", filename);

    //         // 使用DFS显示遍历顺序
    //         let mut dfs = DfsContext::<Block>::default();
    //         println!("\nDFS traversal after optimization:");
    //         println!("Pre-order:");
    //         for block in dfs.pre_order_iter(&ctx, func) {
    //             println!("  {}", block.name(&ctx));
    //         }
    //         println!("Post-order:");
    //         for block in dfs.post_order_iter(&ctx, func) {
    //             println!("  {}", block.name(&ctx));
    //         }
    //     }
    // }


    if let Some(ir_file) = emit_llvm_ir {
        std::fs::write(ir_file, ctx.to_string()).unwrap();
    }

    Ok(())
}
