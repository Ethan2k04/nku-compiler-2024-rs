//! Parser for SysY language.
//! This module guides LALRPOP to generate the parser for SysY language.
use hexponent::FloatLiteral;
use lalrpop_util::lalrpop_mod;

// Define a module named `parser` and generate the parser according to the
// grammar in `sysy.lalrpop` to `src/frontend/sysy.rs`.
lalrpop_mod!(#[allow(clippy::all)] pub parser, "/frontend/sysy.rs");

/// Parse a given hexadecimal float string into a f32.
pub fn parse_hexadecimal_float(s: &str) -> f32 {
    let float_literal: FloatLiteral = s.parse().unwrap();
    // because we want it to be precise, so we have to use a temp f64.
    let result = float_literal.convert::<f64>();
    result.inner() as f32
}

// Make top-level parser public.
pub use parser::NumberParser;
pub use parser::SysYParser;
