#[derive(Debug)]
pub struct CompUnit {
    pub items: Vec<Item>,   
}

#[derive(Debug)]
pub enum Item {
    Decl(Decl),
    FuncDef(FuncDef),
}

#[derive(Debug)]
pub enum Decl {
    ConstDecl(ConstDecl),
    VarDecl(VarDecl),
}

#[derive(Debug)]
pub enum Type {
    Void,
    Bool,
    Int,
    Float,
}

#[derive(Debug)]
pub struct ConstDecl {
    pub ty: Type,
    pub defs: Vec<ConstDef>,
}

#[derive(Debug)]
pub struct ConstDef {
    pub ident: String,
    pub dims: Vec<Exp>,
    pub init: ConstInitVal,
}

#[derive(Debug)]
pub enum ConstInitVal {
    Exp(Exp),
    InitList(Vec<ConstInitVal>),
}

#[derive(Debug)]
pub struct VarDecl {
    pub ty: Type,
    pub defs: Vec<VarDef>,
}

#[derive(Debug)]
pub struct VarDef {
    pub ident: String,
    pub dims: Vec<Exp>,
    pub init: Option<InitVal>,
}

#[derive(Debug)]
pub enum InitVal {
    Exp(Exp),
    InitList(Vec<InitVal>),
}

#[derive(Debug)]
pub struct FuncDef {
    pub ret_ty: Type,
    pub ident: String,
    pub params: Vec<FuncFParam>,
    pub body: Block,
}

#[derive(Debug)]
pub struct FuncFParam {
    pub ty: Type,
    pub ident: String,
    pub dims: Option<Vec<Exp>>,
}

#[derive(Debug)]
pub struct Block {
    pub items: Vec<BlockItem>,
}

#[derive(Debug)]
pub enum BlockItem {
    Decl(Decl),
    Stmt(Stmt),
}

#[derive(Debug)]
pub enum Stmt {
    Assign(AssignStmt),
    Exp(ExpStmt),
    Block(Block),
    If(Box<IfStmt>),
    While(Box<WhileStmt>),
    Break,
    Continue,
    Return(ReturnStmt),
}

#[derive(Debug)]
pub struct AssignStmt {
    pub lval: LVal,
    pub exp: Exp,
}

#[derive(Debug)]
pub struct ExpStmt {
    pub exp: Option<Exp>,
}

#[derive(Debug)]
pub struct IfStmt {
    pub cond: Exp,
    pub then: Box<Stmt>,
    pub else_: Option<Box<Stmt>>,
}

#[derive(Debug)]
pub struct WhileStmt {
    pub cond: Exp,
    pub body: Box<Stmt>,
}

#[derive(Debug)]
pub struct Return {
    pub exp: Option<Exp>,
}

#[derive(Debug)]
pub enum ExpKind {
    Const(ComptimeVal),
    Binary(BinaryOp, Box<Exp>, Box<Exp>),
    Unary(UnaryOp, Box<Exp>),
    FuncCall(FuncCall),
    LVal(LVal),
    InitList(Vec<Exp>),
    Coercion(Box<Exp>),
}

#[derive(Debug)]
pub struct Exp {
    pub kind: ExpKind,
    pub ty: Option<Type>,
}

#[derive(Debug)]
pub enum ComptimeVal {
    Bool(bool),
    Int(i64),
    Float(f32),
    List(Vec<ComptimeVal>),
}

#[derive(Debug)]
pub struct LVal {
    pub ident: String,
    pub indices: Vec<Exp>,
}

#[derive(Debug)]
pub struct FuncCall {
    pub ident: String,
    pub args: Vec<Exp>,
}

#[derive(Debug)]
pub enum UnaryOp {
    Pos,
    Neg,
    Not,
}

#[derive(Debug)]
pub enum BinaryOp {
    Add,
    Sub,
    Mul,
    Div,
    Mod,
    And,
    Or,
    Eq,
    Ne,
    Lt,
    Gt,
    Le,
    Ge,
}

#[derive(Debug)]
pub struct ReturnStmt {
    pub exp: Option<Exp>,
}

use std::fmt::{self, Display, Formatter};

impl Display for CompUnit {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        writeln!(f, "CompUnit")?;
        for (i, item) in self.items.iter().enumerate() {
            if i == self.items.len() - 1 {
                write!(f, "└── {}", item)?;
            } else {
                writeln!(f, "└── {}", item)?;
            }
        }
        Ok(())
    }
}

impl Display for Item {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Item::Decl(d) => write!(f, "{}", d),
            Item::FuncDef(fd) => write!(f, "{}", fd),
        }
    }
}

impl Display for FuncDef {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        writeln!(f, "FuncDef {} {}", self.ret_ty, self.ident)?;
        write!(f, "  └── {}", self.body)
    }
}

impl Display for Block {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        writeln!(f, "Block {{")?;
        for (i, item) in self.items.iter().enumerate() {
            if i == self.items.len() - 1 {
                writeln!(f, "    └── {}", item)?;
            } else {
                writeln!(f, "    ├── {}", item)?;
            }
        }
        write!(f, "  └── }}")
    }
}

impl Display for BlockItem {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            BlockItem::Decl(d) => write!(f, "{}", d),
            BlockItem::Stmt(s) => write!(f, "{}", s),
        }
    }
}

impl Display for Stmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Stmt::Assign(a) => write!(f, "{}", a),
            Stmt::Exp(e) => write!(f, "{}", e),
            Stmt::Block(b) => write!(f, "{}", b),
            Stmt::If(i) => write!(f, "{}", i),
            Stmt::While(w) => write!(f, "{}", w),
            Stmt::Break => write!(f, "break"),
            Stmt::Continue => write!(f, "continue"),
            Stmt::Return(r) => {
                write!(f, "return")?;
                if let Some(exp) = &r.exp {
                    write!(f, " {}", exp)?;
                }
                Ok(())
            }
        }
    }
}

impl Display for ExpStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        if let Some(exp) = &self.exp {
            write!(f, "{}", exp)
        } else {
            Ok(())
        }
    }
}

impl Display for Exp {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match &self.kind {
            ExpKind::Const(c) => write!(f, "{}", c),
            ExpKind::Binary(op, lhs, rhs) => write!(f, "({} {} {})", lhs, op, rhs),
            ExpKind::Unary(op, exp) => write!(f, "{}{}", op, exp),
            ExpKind::FuncCall(fc) => {
                write!(f, "{}(", fc.ident)?;
                for (i, arg) in fc.args.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", arg)?;
                }
                write!(f, ")")
            }
            ExpKind::LVal(lval) => write!(f, "{}", lval),
            ExpKind::InitList(exps) => {
                write!(f, "{{")?;
                for (i, exp) in exps.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", exp)?;
                }
                write!(f, "}}")
            }
            ExpKind::Coercion(exp) => write!(f, "{}", exp),
        }
    }
}

impl Display for Type {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Type::Void => write!(f, "Void"),
            Type::Bool => write!(f, "Bool"),
            Type::Int => write!(f, "Int"),
            Type::Float => write!(f, "Float"),
        }
    }
}

impl Display for ComptimeVal {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            ComptimeVal::Bool(b) => write!(f, "{}", b),
            ComptimeVal::Int(i) => write!(f, "{}", i),
            ComptimeVal::Float(fl) => write!(f, "{}", fl),
            ComptimeVal::List(l) => {
                write!(f, "[")?;
                for (i, val) in l.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", val)?;
                }
                write!(f, "]")
            }
        }
    }
}

impl Display for UnaryOp {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            UnaryOp::Pos => write!(f, "+"),
            UnaryOp::Neg => write!(f, "Neg"),
            UnaryOp::Not => write!(f, "!"),
        }
    }
}

impl Display for BinaryOp {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            BinaryOp::Add => write!(f, "+"),
            BinaryOp::Sub => write!(f, "-"),
            BinaryOp::Mul => write!(f, "*"),
            BinaryOp::Div => write!(f, "/"),
            BinaryOp::Mod => write!(f, "%"),
            BinaryOp::And => write!(f, "&&"),
            BinaryOp::Or => write!(f, "||"),
            BinaryOp::Eq => write!(f, "=="),
            BinaryOp::Ne => write!(f, "!="),
            BinaryOp::Lt => write!(f, "<"),
            BinaryOp::Gt => write!(f, ">"),
            BinaryOp::Le => write!(f, "<="),
            BinaryOp::Ge => write!(f, ">="),
        }
    }
}

impl Display for Decl {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Decl::ConstDecl(cd) => write!(f, "{}", cd),
            Decl::VarDecl(vd) => write!(f, "{}", vd),
        }
    }
}

impl Display for ConstDecl {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "const {} ", self.ty)?;
        for (i, def) in self.defs.iter().enumerate() {
            if i > 0 {
                write!(f, ", ")?;
            }
            write!(f, "{}", def)?;
        }
        Ok(())
    }
}

impl Display for VarDecl {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "{} ", self.ty)?;
        for (i, def) in self.defs.iter().enumerate() {
            if i > 0 {
                write!(f, ", ")?;
            }
            write!(f, "{}", def)?;
        }
        Ok(())
    }
}

impl Display for ConstDef {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.ident)?;
        for dim in &self.dims {
            write!(f, "[{}]", dim)?;
        }
        write!(f, " = {}", self.init)
    }
}

impl Display for VarDef {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.ident)?;
        for dim in &self.dims {
            write!(f, "[{}]", dim)?;
        }
        if let Some(init) = &self.init {
            write!(f, " = {}", init)?;
        }
        Ok(())
    }
}

impl Display for ConstInitVal {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            ConstInitVal::Exp(e) => write!(f, "{}", e),
            ConstInitVal::InitList(list) => {
                write!(f, "{{")?;
                for (i, val) in list.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", val)?;
                }
                write!(f, "}}")
            }
        }
    }
}

impl Display for InitVal {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            InitVal::Exp(e) => write!(f, "{}", e),
            InitVal::InitList(list) => {
                write!(f, "{{")?;
                for (i, val) in list.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", val)?;
                }
                write!(f, "}}")
            }
        }
    }
}

impl Display for AssignStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "{} = {}", self.lval, self.exp)
    }
}

impl Display for IfStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "if ({}) {}", self.cond, self.then)?;
        if let Some(else_stmt) = &self.else_ {
            write!(f, " else {}", else_stmt)?;
        }
        Ok(())
    }
}

impl Display for WhileStmt {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "while ({}) {}", self.cond, self.body)
    }
}

impl Display for LVal {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.ident)?;
        for idx in &self.indices {
            write!(f, "[{}]", idx)?;
        }
        Ok(())
    }
}