use std::path::Path;
use std::process::Command as SysCommand;

use clap::{Arg, ArgMatches, Command};
use compiler_in_rust::frontend::{irgen, preprocess, SysYParser};
use compiler_in_rust::ir::{FuncKind, Block, Func};
use compiler_in_rust::utils::cfg::CfgInfo;
use compiler_in_rust::utils::dfs::{DfsContext};
use compiler_in_rust::infra::storage::{ArenaPtr, Idx};
use compiler_in_rust::utils::dominance::Dominance;
use compiler_in_rust::infra::linked_list::{LinkedListContainer, LinkedListNode};
use compiler_in_rust::ir::passes::dce;
use compiler_in_rust::ir::passes::mem2reg::SimpleMem2Reg;
use compiler_in_rust::backend::codegen::CodegenContext;

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

    ast.type_check();

    println!("{:#?}", ast);

    let mut ctx = irgen(&ast, 8);

    // // 运行 mem2reg 优化
    // let mut mem2reg = SimpleMem2Reg;
    // let changed = mem2reg.run(&mut ctx);
    // if changed {
    //     println!("\nMem2Reg made changes to the IR");
    // } else {
    //     println!("\nMem2Reg made no changes"); 
    // }

    // // 运行死代码删除
    // let mut dce = dce::UnreachableCodeElimination;
    // let changed = dce.run(&mut ctx);
    // match changed {
    //     Ok(changed) => {
    //         if changed {
    //             println!("\nDCE made changes to the IR");
    //         } else {
    //             println!("\nDCE made no changes");
    //         }
    //     }
    //     Err(e) => {
    //         println!("\nDCE failed with error: {:?}", e);
    //     }
    // }

    if let Some(ir_file) = emit_llvm_ir {
        std::fs::write(ir_file, ctx.to_string()).unwrap();
    }

    // Initialize the codegen context.
    let mut codegen_ctx = CodegenContext::new(&ctx);

    // Set architecture string.
    codegen_ctx.mctx_mut().set_arch("rv64imafdc_zba_zbb");

    // Do the codegen and emit virtual register assembly.
    codegen_ctx.codegen();
    println!("{}", codegen_ctx.mctx().display());

    // Do the register allocation.
    codegen_ctx.regalloc();
    println!("{}", codegen_ctx.mctx().display());

    // Additional work after register allocation.
    // codegen_ctx.after_regalloc();

    // Emit the final assembly.
    let mctx = codegen_ctx.finish();
    // println!("{}", mctx.display());

    // Write the generated assembly to the output file.
    let assembly_output = mctx.display().to_string();
    std::fs::write(output.unwrap(), assembly_output)?;

    Ok(())
}
