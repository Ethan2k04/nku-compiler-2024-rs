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
    let args = Cli::parse();
    let input = read_to_string(&args.input)?;
    let parser = SysYParser::new();
    let ast = parser.parse(&input).unwrap();
    // println!("{:#?}", ast);
    println!(
        "{} {} {}",
        "=".repeat(12),
        "Abstract Syntax Tree",
        "=".repeat(12)
    );
    println!("{}", ast);
    Ok(())
}
