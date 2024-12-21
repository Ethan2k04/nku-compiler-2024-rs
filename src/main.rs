use std::path::Path;
use std::process::Command as SysCommand;

use clap::{Arg, ArgMatches, Command};
use compiler_in_rust::frontend::{irgen, preprocess, SysYParser};
use compiler_in_rust::ir::{FuncKind, Block, Func};
use compiler_in_rust::utils::cfg::CfgInfo;

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

    let ir = irgen(&ast, 8);

    // 生成合并的 DOT 文件
    let combined_dot = CfgInfo::<Block, Func>::combine_cfgs(&ir);
    std::fs::write("combined_cfg.dot", combined_dot)?;

    if let Some(ir_file) = emit_llvm_ir {
        std::fs::write(ir_file, ir.to_string()).unwrap();
    }

    Ok(())
}
