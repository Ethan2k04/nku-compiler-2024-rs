mod frontend;

use std::fs::read_to_string;
use std::io::Result;
use frontend::SysYParser;
use clap::Parser;

#[derive(Parser)]
#[command(name = "NKUCC Compiler")]
#[command(about = "A simple compiler using NKUCC frontend", long_about = None)]
struct Cli {
    /// 输入的 SysY 文件路径
    #[arg(short, long, value_name = "FILE")]
    input: String,
}

fn main() -> Result<()> {
    let input = read_to_string(Cli::parse().input)?;
    let parser = SysYParser::new();
    let mut ast = parser.parse(&input).unwrap();
    // println!("{:#?}", ast);
    println!(
        "{} {} {}",
        "=".repeat(12),
        "Abstract Syntax Tree",
        "=".repeat(12)
    );
    println!("{:#?}", ast);

    ast.type_check();

    println!(
        "{} {} {}",
        "=".repeat(12),
        "After type check",
        "=".repeat(12)
    );

    println!("{:#?}", ast);
    println!("{}", ast);

    Ok(())
}
