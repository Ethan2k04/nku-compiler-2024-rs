#[derive(Debug)]
pub enum IrGenResult {
    Global(Global),
    Value(Value),
}

#[derive(Debug)]
pub struct Global;


#[derive(Debug)]
pub struct Value;