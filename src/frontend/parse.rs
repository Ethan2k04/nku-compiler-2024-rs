use lalrpop_util::lalrpop_mod;
use hexponent::FloatLiteral;

lalrpop_mod!(#[allow(clippy::all)] pub sysy);

/// Parse a given hexadecimal float string into a f32.
/// reference: https://github.com/JuniMay/orzcc/blob/master/src/frontend/sysy/parse.rs 7~12
pub fn parse_hexadecimal_float(s: &str) -> f32 {
    let float_literal: FloatLiteral = s.parse().unwrap();
    // because we want it to be precise, so we have to use a temp f64.
    let result = float_literal.convert::<f64>();
    result.inner() as f32
}

pub use sysy::*;