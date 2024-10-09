// use nkucc::frontend::{irgen, preprocess, SysYParser};

// fn main() -> Result<(), Box<dyn std::error::Error>> {
//     println!("Hello, NKUCC!");

//     let src = std::fs::read_to_string("tests/sysy/basic.sy")?;
//     let src = preprocess(&src);

//     let mut ast = SysYParser::new().parse(&src).unwrap();

//     ast.type_check();

//     println!(
//         "{} {} {}",
//         "=".repeat(12),
//         "Abstract Syntax Tree",
//         "=".repeat(12)
//     );

//     println!("{:#?}", ast);

//     let ir = irgen(&ast, 8);

//     println!(
//         "\n{} {} {}",
//         "=".repeat(12),
//         "Intermediate Representation",
//         "=".repeat(12)
//     );

//     println!("{}", ir);

//     Ok(())
// }

use nkucc::frontend::NumberParser;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("Hello, NKUCC!");
    let int_str = String::from("/* xxxx */ 114514 // 123");
    let hex_str = String::from("/* xxxx */ 0xfff // 123");
    assert_eq!(parse_int(&int_str), 114514);
    assert_eq!(parse_int(&hex_str), 0xfff);
    println!("lexer test passed");
    Ok(())
}
fn parse_int(str: &str) -> i32 {
    // TODO: use NumberParser to parse int
    NumberParser::new().parse(str).unwrap().unwrap_int()
}
