//! Abstract Syntax Tree (AST) for the SysY language.

use super::symbol_table::{SymbolEntry, SymbolTable};
use super::types::{Type, TypeKind as Tk};

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
pub struct ConstDecl {
    pub ty: Type,
    pub defs: Vec<ConstDef>,
}

#[derive(Debug)]
pub struct ConstDef {
    pub ident: String,
    pub dims: Vec<Exp>,
    pub init: Exp,
}

// #[derive(Debug)]
// pub enum ConstInitVal {
//     Exp(Exp),
//     InitList(Vec<ConstInitVal>),
// }

#[derive(Debug)]
pub struct VarDecl {
    pub ty: Type,
    pub defs: Vec<VarDef>,
}

#[derive(Debug)]
pub struct VarDef {
    pub ident: String,
    pub dims: Vec<Exp>,
    pub init: Option<Exp>,
}

// #[derive(Debug)]
// pub enum InitVal {
//     Exp(Exp),
//     InitList(Vec<InitVal>),
// }

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
    /// Assignment statement.
    /// e.g. `a = 1;` or `a[0] = 1;`
    Assign(AssignStmt),
    /// Expression statement.
    /// e.g. `1 + 2;`
    Exp(ExpStmt),
    /// Block statement.
    /// e.g. `{ ... }`
    Block(Block),
    /// If statement.
    /// e.g. `if (a) { ... } else { ... }`
    If(Box<IfStmt>),
    /// While statement.
    /// e.g. `while (a) { ... }`
    While(Box<WhileStmt>),
    /// Break statement.
    /// e.g. `break;`
    Break,
    /// Continue statement.
    /// e.g. `continue;`
    Continue,
    /// Return statement.
    /// e.g. `return 1;`
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

#[derive(Debug, Clone)]
pub enum ExpKind {
    Const(ComptimeVal),
    Binary(BinaryOp, Box<Exp>, Box<Exp>),
    Unary(UnaryOp, Box<Exp>),
    FuncCall(FuncCall),
    LVal(LVal),
    InitList(Vec<Exp>),
    Coercion(Box<Exp>),
}

/// Expression.
#[derive(Debug, Clone)]
pub struct Exp {
    /// kind of the expression.
    pub kind: ExpKind,
    /// Type of the expression.
    /// Its generated during type checking.
    pub ty: Option<Type>,
}

/// Represents a constant value that can be evaluated at compile time.
#[derive(Debug, Clone)]
pub enum ComptimeVal {
    Bool(bool),
    Int(i64),
    Float(f32),
    List(Vec<ComptimeVal>),
    Undef(Type),
    /// Design for situation like `int a[4] = {}`
    Zero(Type),
}

#[derive(Debug, Clone)]
pub struct LVal {
    pub ident: String,
    pub indices: Vec<Exp>,
}

#[derive(Debug, Clone)]
pub struct FuncCall {
    pub ident: String,
    pub args: Vec<Exp>,
}

/// Unary operators.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum UnaryOp {
    Pos,
    Neg,
    Not,
}

/// Binary operators.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
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

impl ComptimeVal {
    /// Unwrap the comptime value as a int
    pub fn unwrap_int(&self) -> i64 {
        match self {
            Self::Bool(b) => *b as i64,
            Self::Int(i) => *i,
            Self::Float(f) => *f as i64,
            Self::Zero(_) => 0,
            Self::List(_) => panic!("unwrapping list comptime value"),
            Self::Undef(_) => panic!("unwrapping undefined comptime value"),
        }
    }

    /// Get the type of the comptime value.
    pub fn get_type(&self) -> Type {
        match self {
            Self::Bool(_) => Type::bool(),
            Self::Int(_) => Type::int(),
            Self::Float(_) => Type::float(),
            Self::Undef(ty) => ty.clone(),
            Self::Zero(ty) => ty.clone(),
            Self::List(vals) => {
                let elem_ty = vals.first().unwrap().get_type();
                Type::array(elem_ty, vals.len()) 
            }
        }
    }

    /// Create a comptime value from a boolean.
    pub fn bool(b: bool) -> Self {
        Self::Bool(b)
    }

    /// Create a comptime value from an integer.
    pub fn int(i: i64) -> Self {
        Self::Int(i)
    }

    /// Create a comptime value from a float.
    pub fn float(f: f32) -> Self {
        Self::Float(f)
    }

    /// Create a comptime value from a list of comptime values.
    pub fn list(l: Vec<ComptimeVal>) -> Self {
        Self::List(l)
    }

    /// Create a comptime value that represents an undefined value.
    pub fn undef(ty: Type) -> Self {
        Self::Undef(ty)
    }

    /// Check if the comptime value is zero.
    pub fn is_zero(&self) -> bool {
        match self {
            Self::Bool(b) => !*b,
            Self::Int(i) => *i == 0,
            Self::Float(f) => *f == 0.0,
            Self::Zero(_) => true,
            Self::Undef(_) => false,
            Self::List(l) => l.iter().all(ComptimeVal::is_zero),
        }
    }

    /// Compute the logical OR of two comptime values.
    pub fn logical_or(&self, other: &Self) -> Self {
        let lhs = match self {
            Self::Bool(a) => *a,
            Self::Int(a) => *a != 0,
            Self::Float(a) => *a != 0.0,
            Self::Zero(_) => false,
            Self::List(_) => panic!("logical OR with list comptime value"),
            Self::Undef(_) => panic!("logical OR with undefined comptime value"),
        };

        let rhs = match other {
            Self::Bool(b) => *b,
            Self::Int(b) => *b != 0,
            Self::Float(a) => *a != 0.0,
            Self::Zero(_) => false,
            Self::List(_) => panic!("logical OR with list comptime value"),
            Self::Undef(_) => panic!("logical OR with undefined comptime value"),
        };

        Self::Bool(lhs || rhs)
    }

    /// Compute the logical AND of two comptime values.
    pub fn logical_and(&self, other: &Self) -> Self {
        let lhs = match self {
            Self::Bool(a) => *a,
            Self::Int(a) => *a != 0,
            Self::Float(a) => *a != 0.0,
            Self::Zero(_) => false,
            Self::List(_) => panic!("logical AND with list comptime value"),
            Self::Undef(_) => panic!("logical AND with undefined comptime value"),
        };

        let rhs = match other {
            Self::Bool(b) => *b,
            Self::Int(b) => *b != 0,
            Self::Float(a) => *a != 0.0,
            Self::Zero(_) => false,
            Self::List(_) => panic!("logical AND with list comptime value"),
            Self::Undef(_) => panic!("logical AND with undefined comptime value"),
        };

        Self::Bool(lhs && rhs)
    }
}

impl PartialEq for ComptimeVal {
    fn eq(&self, other: &Self) -> bool {
        use ComptimeVal as Cv;
        match (self, other) {
            (Cv::Bool(a), Cv::Bool(b)) => a == b,
            (Cv::Int(a), Cv::Int(b)) => a == b,
            (Cv::Float(a), Cv::Float(b)) => a == b,

            // Coercion situations, bool -> int
            (Cv::Bool(a), Cv::Int(b)) => (*a as i64) == *b,
            (Cv::Int(a), Cv::Bool(b)) => *a == (*b as i64),

            // Coercion situations, int -> float
            (Cv::Int(a), Cv::Float(b)) => (*a as f32) == *b,
            (Cv::Float(a), Cv::Int(b)) => *a == (*b as f32),

            // Coercion situations, bool -> float
            (Cv::Bool(a), Cv::Float(b)) => (*a as i32 as f32) == *b,
            (Cv::Float(a), Cv::Bool(b)) => *a == (*b as i32 as f32),

            _ => false,
        }
    }
}

impl Eq for ComptimeVal {}

impl PartialOrd for ComptimeVal {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        use ComptimeVal as Cv;
        match (self, other) {
            (Cv::Bool(a), Cv::Bool(b)) => a.partial_cmp(b),
            (Cv::Int(a), Cv::Int(b)) => a.partial_cmp(b),
            (Cv::Float(a), Cv::Float(b)) => a.partial_cmp(b),

            // Coercion situations, bool -> int
            (Cv::Bool(a), Cv::Int(b)) => (*a as i64).partial_cmp(b),
            (Cv::Int(a), Cv::Bool(b)) => a.partial_cmp(&(*b as i64)),

            // Coercion situations, int -> float
            (Cv::Int(a), Cv::Float(b)) => (*a as f32).partial_cmp(b),
            (Cv::Float(a), Cv::Int(b)) => a.partial_cmp(&(*b as f32)),

            // Coercion situations, bool -> float
            (Cv::Bool(a), Cv::Float(b)) => (*a as i32 as f32).partial_cmp(b),
            (Cv::Float(a), Cv::Bool(b)) => a.partial_cmp(&(*b as i32 as f32)),

            _ => None,
        }
    }
}

impl std::ops::Add for ComptimeVal {
    type Output = Self;

    fn add(self, other: Self) -> Self {
        use ComptimeVal as Cv;
        match (self, other) {
            (Cv::Int(a), Cv::Int(b)) => Cv::Int(a + b),
            (Cv::Float(a), Cv::Float(b)) => Cv::Float(a + b),

            // coercion situations, bool -> int
            (Cv::Bool(a), Cv::Int(b)) => Cv::Int(a as i64 + b),
            (Cv::Int(a), Cv::Bool(b)) => Cv::Int(a + b as i64),
            (Cv::Bool(a), Cv::Bool(b)) => Cv::Int(a as i64 + b as i64),

            // coercion situations, int -> float
            (Cv::Int(a), Cv::Float(b)) => Cv::Float(a as f32 + b),
            (Cv::Float(a), Cv::Int(b)) => Cv::Float(a + b as f32),

            // coercion situations, bool -> float
            (Cv::Bool(a), Cv::Float(b)) => Cv::Float(a as i32 as f32 + b),
            (Cv::Float(a), Cv::Bool(b)) => Cv::Float(a + b as i32 as f32),

            _ => panic!("unsupported addition"),
        }
    }
}

impl std::ops::Sub for ComptimeVal {
    type Output = Self;

    fn sub(self, other: Self) -> Self {
        use ComptimeVal as Cv;

        match (self, other) {
            (Cv::Int(a), Cv::Int(b)) => Cv::Int(a - b),
            (Cv::Float(a), Cv::Float(b)) => Cv::Float(a - b),

            // coercion situations, bool -> int
            (Cv::Bool(a), Cv::Int(b)) => Cv::Int(a as i64 - b),
            (Cv::Int(a), Cv::Bool(b)) => Cv::Int(a - b as i64),
            (Cv::Bool(a), Cv::Bool(b)) => Cv::Int(a as i64 - b as i64),

            // coercion situations, int -> float
            (Cv::Int(a), Cv::Float(b)) => Cv::Float(a as f32 - b),
            (Cv::Float(a), Cv::Int(b)) => Cv::Float(a - b as f32),

            // coercion situations, bool -> float
            (Cv::Bool(a), Cv::Float(b)) => Cv::Float(a as i32 as f32 - b),
            (Cv::Float(a), Cv::Bool(b)) => Cv::Float(a - b as i32 as f32),

            _ => panic!("unsupported subtraction"),
        }
    }
}

impl std::ops::Mul for ComptimeVal {
    type Output = Self;

    fn mul(self, other: Self) -> Self {
        use ComptimeVal as Cv;
        match (self, other) {
            (Cv::Int(a), Cv::Int(b)) => Cv::Int(a * b),
            (Cv::Float(a), Cv::Float(b)) => Cv::Float(a * b),

            // coercion situations, bool -> int
            (Cv::Bool(a), Cv::Int(b)) => Cv::Int(a as i64 * b),
            (Cv::Int(a), Cv::Bool(b)) => Cv::Int(a * b as i64),
            (Cv::Bool(a), Cv::Bool(b)) => Cv::Int(a as i64 * b as i64),

            // coercion situations, int -> float
            (Cv::Int(a), Cv::Float(b)) => Cv::Float(a as f32 * b),
            (Cv::Float(a), Cv::Int(b)) => Cv::Float(a * b as f32),

            // coercion situations, bool -> float
            (Cv::Bool(a), Cv::Float(b)) => Cv::Float(a as i32 as f32 * b),
            (Cv::Float(a), Cv::Bool(b)) => Cv::Float(a * b as i32 as f32),

            _ => panic!("unsupported multiplication"),
        }
    }
}

impl std::ops::Div for ComptimeVal {
    type Output = Self;

    fn div(self, other: Self) -> Self {
        use ComptimeVal as Cv;
        match (self, other) {
            (Cv::Int(a), Cv::Int(b)) => Cv::Int(a / b),
            (Cv::Float(a), Cv::Float(b)) => Cv::Float(a / b),

            // coercion situations, bool -> int
            (Cv::Bool(a), Cv::Int(b)) => Cv::Int(a as i64 / b),
            (Cv::Int(a), Cv::Bool(b)) => Cv::Int(a / b as i64),
            (Cv::Bool(a), Cv::Bool(b)) => Cv::Int(a as i64 / b as i64),

            // coercion situations, int -> float
            (Cv::Int(a), Cv::Float(b)) => Cv::Float(a as f32 / b),
            (Cv::Float(a), Cv::Int(b)) => Cv::Float(a / b as f32),
            
            // coercion situations, bool -> float
            (Cv::Bool(a), Cv::Float(b)) => Cv::Float(a as i32 as f32 / b),
            (Cv::Float(a), Cv::Bool(b)) => Cv::Float(a / b as i32 as f32),

            _ => panic!("unsupported division"),
        }
    }
}

impl std::ops::Rem for ComptimeVal {
    type Output = Self;

    fn rem(self, other: Self) -> Self {
        use ComptimeVal as Cv;
        match (self, other) {
            (Cv::Int(a), Cv::Int(b)) => Cv::Int(a % b),
            (Cv::Float(a), Cv::Float(b)) => Cv::Float(a % b),

            // bool -> int
            (Cv::Bool(a), Cv::Bool(b)) => Cv::Int(a as i64 % b as i64),
            (Cv::Bool(a), Cv::Int(b)) => Cv::Int(a as i64 % b),
            (Cv::Int(a), Cv::Bool(b)) => Cv::Int(a % b as i64),

            // int -> float
            (Cv::Int(a), Cv::Float(b)) => Cv::Float(a as f32 % b),
            (Cv::Float(a), Cv::Int(b)) => Cv::Float(a % b as f32),

            // bool -> float
            (Cv::Bool(a), Cv::Float(b)) => Cv::Float(a as i32 as f32 % b),
            (Cv::Float(a), Cv::Bool(b)) => Cv::Float(a % b as i32 as f32),

            _ => panic!("unsupported remainder"),
        }
    }
}

impl std::ops::Neg for ComptimeVal {
    type Output = Self;

    fn neg(self) -> Self {
        use ComptimeVal as Cv;
        match self {
            Cv::Bool(a) => Cv::Int(-(a as i64)),
            Cv::Int(a) => Cv::Int(-a),
            Cv::Float(a) => Cv::Float(-a),
            Cv::Zero(ty) => Cv::Zero(ty),
            Cv::List(_) => panic!("negating list comptime value"),
            Cv::Undef(_) => panic!("negating undefined comptime value"),
        }
    }
}

impl std::ops::Not for ComptimeVal {
    type Output = Self;

    fn not(self) -> Self {
        use ComptimeVal as Cv;
        match self {
            Cv::Bool(a) => Cv::Bool(!a),
            Cv::Int(a) => Cv::Bool(a != 0),
            Cv::Float(a) => Cv::Bool(a != 0.0),
            Cv::Zero(_) => Cv::Bool(false),
            Cv::List(_) => panic!("logical NOT with list comptime value"),
            Cv::Undef(_) => panic!("logical NOT with undefined comptime value"),
        }
    }
}

impl Exp {
    pub fn const_(val: ComptimeVal) -> Self {
        let ty = val.get_type();
        Self {
            kind: ExpKind::Const(val),
            ty: Some(ty),
        }
    }

    /// coerce the expression to a specific type
    pub fn coercion(exp: Exp, to: Type) -> Self {
        if let Some(ref from) = exp.ty {
            if from == &to {
                return exp;
            }
        }

        Self {
            kind: ExpKind::Coercion(Box::new(exp)),
            ty: Some(to),
        }
    }
}

// Implement type check for the AST structs.

impl CompUnit {
    /// Type check the compilation unit.
    pub fn type_check(&mut self) {
        let mut symtable = SymbolTable::default();
        symtable.enter_scope();

        // register SysY library functions in the top level scope
        symtable.register_sysylib();

        // type check each item
        for item in self.items.iter_mut() {
            item.type_check(&mut symtable);
        }

        symtable.leave_scope();
    }
}

impl Item {
    /// Type check the item.
    pub fn type_check(&mut self, symtable: &mut SymbolTable) {
        match self {
            Item::Decl(decl) => match decl {
                Decl::ConstDecl(cd) => cd.type_check(symtable),
                Decl::VarDecl(vd) => vd.type_check(symtable),
            },
            Item::FuncDef(FuncDef {
                ret_ty,
                ident,
                params,
                body,
            }) => {
                // Enter a new scope for function parameters
                symtable.enter_scope();

                // Insert the function parameters into the scope
                let mut param_tys = Vec::new();
                for param in params.iter() {
                    let ty = if let Some(ref indices) = param.dims {
                        let mut ty = param.ty.clone();
                        for dim in indices.iter().rev() {
                            let dim = dim.try_fold(symtable).expect("const expr expected");
                            ty = Type::array(ty, dim.unwrap_int() as usize);
                        }
                        ty = Type::pointer(ty);
                        ty
                    } else {
                        param.ty.clone()
                    };
                    param_tys.push(ty.clone());
                    symtable.insert(param.ident.clone(), SymbolEntry::from_ty(ty));
                }

                let func_ty = Type::func(param_tys, ret_ty.clone());

                // Insert the function symbol into the scope above the current scope, since we
                // are in the parameters scope
                symtable.insert_upper(ident.clone(), SymbolEntry::from_ty(func_ty), 1);
                symtable.curr_ret_ty = Some(ret_ty.clone());

                // Type check the function body
                body.type_check(symtable);

                symtable.curr_ret_ty = None;
                symtable.leave_scope();
            }
        }
    }
}

impl ConstDecl {
    /// Type check the constant declaration.
    pub fn type_check(&mut self, symtable: &mut SymbolTable) {
        let mut new_defs = Vec::new();
        for mut def in self.defs.drain(..) {
            // TODO✔: array type checking
            let mut array_shape = def
                .dims
                .drain(..)
                .map(|exp| {
                    exp.try_fold(symtable)
                        .expect("Array size must be a constant expression")
                        .unwrap_int()
                })
                .collect::<Vec<_>>();

            let mut ty = self.ty.clone();
            for dim in array_shape.iter().rev() {
                ty = Type::array(ty, *dim as usize);
            }

            def.init = def.init.type_check(Some(&ty), symtable);
            let folded = def.init.try_fold(symtable).expect("non-constant init");
            def.init = Exp::const_(folded.clone());

            def.dims = array_shape
                .drain(..)
                .map(ComptimeVal::int)
                .map(Exp::const_)
                .map(|mut e| {
                    e.ty = Some(Type::int());
                    e
                })
                .collect::<Vec<_>>();

            symtable.insert(
                def.ident.clone(),
                SymbolEntry {
                    ty,
                    comptime: Some(folded),
                    ir_value: None,
                },
            );
            new_defs.push(def);
        }
        self.defs = new_defs;
    }
}

impl VarDecl {
    /// Type check the variable declaration.
    pub fn type_check(&mut self, symtable: &mut SymbolTable) {
        let mut new_defs = Vec::new();
        for mut def in self.defs.drain(..) {
            // TODO✔: array type checking
            let mut array_shape = def
                .dims
                .drain(..)
                .map(|exp| {
                    exp.try_fold(symtable)
                        .expect("Array size must be a constant expression")
                        .unwrap_int()
                })
                .collect::<Vec<_>>();

            let mut ty = self.ty.clone();
            // construct the array type
            for dim in array_shape.iter().rev() {
                ty = Type::array(ty, *dim as usize);
            }

            // type check the init expression, and fold it if possible
            let init = def
                .init
                .map(|init| {
                    let checked_init = init.type_check(Some(&ty), symtable);
                    match checked_init.try_fold(symtable) {
                        Some(val) => Exp::const_(val),
                        None => checked_init,
                    }
                })
                .unwrap_or_else(|| {
                    // TODO✔: assign undef
                    Exp::const_(ComptimeVal::undef(ty.clone()))
                });

            def.init = Some(init);

            def.dims = array_shape
                .drain(..)
                .map(ComptimeVal::int)
                .map(Exp::const_)
                .map(|mut e| {
                    e.ty = Some(Type::int());
                    e
                })
                .collect::<Vec<_>>();

            // Insert the variable into the symbol table
            symtable.insert(def.ident.clone(), SymbolEntry::from_ty(ty));
            new_defs.push(def);
        }
        self.defs = new_defs;
    }
}

impl Block {
    /// Type check the block.
    pub fn type_check(&mut self, symtable: &mut SymbolTable) {
        // Enter a new scope
        symtable.enter_scope();
        let mut new_items = Vec::new();

        // Type check each block item in the block
        for item in self.items.drain(..) {
            let item = match item {
                BlockItem::Decl(mut decl) => match decl {
                    Decl::ConstDecl(mut cd) => {
                        cd.type_check(symtable);
                        BlockItem::Decl(Decl::ConstDecl(cd))
                    }
                    Decl::VarDecl(mut vd) => {
                        vd.type_check(symtable);
                        BlockItem::Decl(Decl::VarDecl(vd))
                    }
                },
                BlockItem::Stmt(mut stmt) => {
                    let stmt = stmt.type_check(symtable);
                    BlockItem::Stmt(stmt)
                }
            };
            new_items.push(item);
        }
        self.items = new_items;
        symtable.leave_scope();
    }
}

impl Stmt {
    /// Type check the statement.
    pub fn type_check(self, symtable: &mut SymbolTable) -> Self {
        match self {
            Stmt::Assign(AssignStmt { lval, exp }) => {
                let entry = symtable.lookup(&lval.ident).expect("variable not found");

                let indices = lval.indices
                    .clone()
                    .into_iter()
                    .map(|idx_exp| idx_exp.type_check(Some(&Type::int()), symtable))
                    .collect::<Vec<_>>();

                let mut ty = &entry.ty;

                // e.g `a[0][1] = 1;` -> indices = [0, 1] -> ty = int[][] -> ty = int[] -> ty = int
                for _ in indices.iter() {
                    match ty.kind() {
                        Tk::Array(inner_ty, _) => {
                            // 更新 ty 为数组的元素类型
                            ty = inner_ty;
                        },
                        Tk::Pointer(inner_ty) => {
                            // 更新 ty 为指针的元素类型
                            ty = inner_ty;
                        },
                        _ => {
                            panic!("indexing a non-array type");
                        }
                    }
                }

                // Type check the expression
                let exp = exp.type_check(Some(ty), symtable);
                Stmt::Assign(AssignStmt { lval, exp })
            },
            Stmt::Exp(ExpStmt { exp }) => {
                // Type check the expression
                let exp = exp.map(|exp| exp.type_check(None, symtable));
                Stmt::Exp(ExpStmt { exp })
            },
            Stmt::Block(mut block) => {
                // Type check the block
                block.type_check(symtable);
                Stmt::Block(block)
            },
            Stmt::Break => Stmt::Break,
            Stmt::Continue => Stmt::Continue,
            Stmt::Return(ReturnStmt { exp }) => {
                // Type check the return expression
                let exp = exp.map(|exp| exp.type_check(symtable.curr_ret_ty.as_ref(), symtable));

                if exp.is_none() {
                    return Stmt::Return(ReturnStmt { exp });
                }

                let mut exp = exp.unwrap();
                let ret_ty = symtable.curr_ret_ty.as_ref().unwrap();

                if ret_ty.is_int() {
                    exp = Exp::coercion(exp, Type::int());
                } else if ret_ty.is_float() {
                    exp = Exp::coercion(exp, Type::float());
                } else {
                    panic!("unsupported return type");
                }

                Stmt::Return(ReturnStmt { exp: Some(exp) })
            },
            Stmt::If(if_stmt) => {
                let IfStmt { cond, then, else_ } = *if_stmt;
                let cond = cond.type_check(Some(&Type::bool()), symtable);
                let then = Box::new(then.type_check(symtable));
                let else_ = else_.map(|block| Box::new(block.type_check(symtable)));
                Stmt::If(Box::new(IfStmt { cond, then, else_ }))
            },
            Stmt::While(while_stmt) => {
                let WhileStmt { cond, body } = *while_stmt;
                let cond = cond.type_check(Some(&Type::bool()), symtable);
                let body = Box::new(body.type_check(symtable));
                Stmt::While(Box::new(WhileStmt { cond, body }))
            }
        }
    }
}

// TODO: Add judegment for if a value is out of i32 range
impl Exp {
    /// Get the type of the expression.
    pub fn ty(&self) -> &Type { self.ty.as_ref().unwrap() }

    /// Type check the expression.
    pub fn type_check(self, expect: Option<&Type>, symtable: &SymbolTable) -> Self {
        // If the expression is already known, and no expected type is
        // given, return the expression as is.
        if self.ty.is_some() && expect.is_none() {
            return self;
        }

        let mut exp = match self.kind {
            ExpKind::Const(_) => self,
            ExpKind::Binary(op, lhs, rhs) => {
                // Type check the left and right hand side expressions
                let mut lhs = lhs.type_check(None, symtable);
                let mut rhs = rhs.type_check(None, symtable);

                let lhs_ty = lhs.ty();
                let rhs_ty = rhs.ty();

                // Coerce the types if needed
                match (lhs_ty.kind(), rhs_ty.kind()) {
                    (Tk::Bool, Tk::Int) => {
                        lhs = Exp::coercion(lhs, Type::int());
                    },
                    (Tk::Int, Tk::Bool) => {
                        rhs = Exp::coercion(rhs, Type::int());
                    },
                    (Tk::Int, Tk::Float) => {
                        lhs = Exp::coercion(lhs, Type::float());
                    },
                    (Tk::Float, Tk::Int) => {
                        rhs = Exp::coercion(rhs, Type::float());
                    },
                    (Tk::Bool, Tk::Float) => {
                        lhs = Exp::coercion(lhs, Type::float());
                    },
                    (Tk::Float, Tk::Bool) => {
                        rhs = Exp::coercion(rhs, Type::float());
                    },
                    _ => {
                        if lhs_ty != rhs_ty {
                            panic!("unsupported type coercion: {:?} -> {:?}", lhs_ty, rhs_ty);
                        }
                    }
                };

                let lhs_ty = lhs.ty().clone();

                // Create the binary expression
                let mut expr = Exp {
                    kind: ExpKind::Binary(op, Box::new(lhs), Box::new(rhs)),
                    ty: None,
                };
                match op {
                    BinaryOp::Add | BinaryOp::Sub | BinaryOp::Mul | BinaryOp::Div | BinaryOp::Mod => {
                        expr.ty = Some(lhs_ty.clone());
                    },
                    BinaryOp::And | BinaryOp::Or | BinaryOp::Eq | BinaryOp::Ne | BinaryOp::Lt | BinaryOp::Gt | BinaryOp::Le | BinaryOp::Ge => {
                        expr.ty = Some(Type::bool());
                    },
                }
                expr
            },
            ExpKind::Unary(op, exp) => {
                // Type check the expression
                let mut exp = exp.type_check(None, symtable);

                // Coerce the expression to int if needed
                let ty = match op {
                    UnaryOp::Neg => {
                        if exp.ty().is_bool() {
                            exp = Exp::coercion(exp, Type::int());
                        }
                        let ty = exp.ty();
                        if ty.is_int() || ty.is_float() {
                            ty.clone()
                        } else {
                            panic!("unsupported type for unary negation: {:?}", ty);
                        }
                    },
                    UnaryOp::Not => {
                        let ty = exp.ty();
                        if ty.is_bool() {
                            // do nothing
                        } if ty.is_int() {
                            exp = Exp {
                                kind: ExpKind::Binary(BinaryOp::Ne, Box::new(exp), Box::new(Exp::const_(ComptimeVal::int(0)))),
                                ty: Some(Type::bool()),
                            }
                        } else if ty.is_float() {
                            exp = Exp {
                                kind: ExpKind::Binary(BinaryOp::Ne, Box::new(exp), Box::new(Exp::const_(ComptimeVal::float(0.0)))),
                                ty: Some(Type::bool()),
                            }
                        } else {
                            panic!("unsupported type for unary not: {:?}", ty);
                        }
                        Type::bool()
                    },
                    UnaryOp::Pos => {
                        let ty = exp.ty();
                        if ty.is_int() || ty.is_float() {
                            ty.clone()
                        } else {
                            panic!("unsupported type for unary pos: {:?}", ty);
                        }
                    },
                };

                Exp {
                    kind: ExpKind::Unary(op, Box::new(exp)),
                    ty: Some(ty),
                }
            },
            ExpKind::Coercion(_) => unreachable!(),
            ExpKind::FuncCall(FuncCall { ident, args }) => {
                // Lookup the function in the symbol table
                let entry = symtable.lookup(&ident).unwrap();

                let (param_tys, ret_ty) = entry.ty.unwrap_func();

                // Type check the arguments
                let args = args
                .into_iter()
                .zip(param_tys)
                .map(|(arg, ty)| arg.type_check(Some(ty), symtable))
                .collect();

                // // Type check the arguments
                // let args = args
                //     .into_iter()
                //     .zip(param_tys)
                //     .map(|(arg, expected_ty)| {
                //         let mut arg = arg.type_check(None, symtable);
                        
                //         // 特殊处理数组类型
                //         if let (Tk::Array(exp_elem_ty, exp_len), Tk::Array(arg_elem_ty, _)) = 
                //             (expected_ty.kind(), arg.ty().kind()) {
                //             if exp_elem_ty == arg_elem_ty && exp_len == &0 {
                //                 // 允许任意长度的数组转换为长度为0的数组（可变长度）
                //                 return arg;
                //             }
                //         }
                        
                //         // 其他情况进行普通类型检查
                //         arg.type_check(Some(expected_ty), symtable)
                //     })
                //     .collect();

                // Create the function call expression
                Exp {
                    kind: ExpKind::FuncCall(FuncCall { ident, args }),
                    ty: Some(ret_ty.clone()),
                }
            },
            ExpKind::LVal(LVal { ident, indices }) => {
                // Lookup the variable in the symbol table
                let entry = symtable.lookup(&ident).unwrap();

                let indices = indices
                    .into_iter()
                    .map(|idx_exp| idx_exp.type_check(Some(&Type::int()), symtable))
                    .collect::<Vec<_>>();

                let mut ty = &entry.ty;

                for _ in indices.iter() {
                    match ty.kind() {
                        Tk::Array(inner_ty, _) => {
                            ty = inner_ty;
                        },
                        Tk::Pointer(inner_ty) => {
                            ty = inner_ty;
                        },
                        _ => {
                            panic!("indexing a non-array type");
                        }
                    }
                }

                let exp = Exp {
                    kind: ExpKind::LVal(LVal { ident, indices }),
                    ty: Some(ty.clone()),
                };
                exp
            },
            ExpKind::InitList(ref list) => {
                let ty = expect.expect("InitList expects a type");

                fn handle_init_list(
                    list: &[Exp],
                    ty: &Type,
                    symtable: &SymbolTable,
                ) -> (Vec<Exp>, usize) {
                    if let Tk::Array(ref elem_ty, len) = ty.kind() {
                        let mut new_vals = Vec::with_capacity(*len);
                        let mut consumed = 0;
                        let mut i = 0;

                        while i < *len {
                            if consumed >= list.len() {
                                // Fill remaining elements with zeros
                                new_vals.push(Exp::const_(ComptimeVal::Zero(elem_ty.clone())));
                                i += 1;
                                continue;
                            }

                            let elem = &list[consumed];

                            match &elem.kind {
                                ExpKind::InitList(sub_list) => {
                                    let (sub_vals, _) = handle_init_list(sub_list, elem_ty, symtable);
                                    new_vals.push(Exp {
                                        kind: ExpKind::InitList(sub_vals),
                                        ty: Some(elem_ty.clone()),
                                    });
                                    consumed += 1;
                                },
                                _ => {
                                    if let Tk::Array(_, _) = elem_ty.kind() {
                                        // 如果需要数组类型，创建一个新的初始化列表
                                        let mut remaining_elems = Vec::new();
                                        // 收集剩余的所有元素
                                        remaining_elems.push(elem.clone());
                                        let mut j = consumed + 1;
                                        while j < list.len() {
                                            remaining_elems.push(list[j].clone());
                                            j += 1;
                                        }
                                        // 递归处理这些元素
                                        let (sub_vals, sub_consumed) = handle_init_list(&remaining_elems, elem_ty, symtable);
                                        new_vals.push(Exp {
                                            kind: ExpKind::InitList(sub_vals),
                                            ty: Some(elem_ty.clone()),
                                        });
                                        consumed += sub_consumed;
                                    } else {
                                        // 基本类型直接进行类型检查
                                        let checked_elem = elem.clone().type_check(Some(elem_ty), symtable);
                                        new_vals.push(checked_elem);
                                        consumed += 1;
                                    }
                                }
                            }
                            i += 1;
                        }

                        (new_vals, consumed)
                    } else {
                        // 处理基本类型
                        let mut new_vals = Vec::new();
                        let consumed = if !list.is_empty() {
                            let checked_elem = list[0].clone().type_check(Some(ty), symtable);
                            new_vals.push(checked_elem);
                            1
                        } else {
                            0
                        };

                        (new_vals, consumed)
                    }
                }

                let (mut new_vals, _) = handle_init_list(list, ty, symtable);

                // 填充不足的部分
                if let Tk::Array(_, len) = ty.kind() {
                    if new_vals.len() < *len {
                        for _ in new_vals.len()..*len {
                            new_vals.push(Exp::const_(ComptimeVal::undef(ty.clone())));
                        }
                    }
                }

                // 检查是否所有值都是零
                if new_vals.iter().all(|val| {
                    if let ExpKind::Const(ref comptime_val) = val.kind {
                        comptime_val.is_zero()
                    } else {
                        false
                    }
                }) {
                    Exp::const_(ComptimeVal::Zero(ty.clone()))
                } else {
                    Exp {
                        kind: ExpKind::InitList(new_vals),
                        ty: Some(ty.clone()),
                    }
                }
            }
        };

        // Coerce the expression to the expected type if needed
        if let Some(ty) = expect {
            if ty.is_int() || ty.is_bool() || ty.is_float() || ty.is_pointer() {
                match ty.kind() {
                    Tk::Bool => exp = Exp::coercion(exp, Type::bool()),
                    Tk::Int => exp = Exp::coercion(exp, Type::int()),
                    Tk::Float => exp = Exp::coercion(exp, Type::float()),
                    Tk::Pointer(..) => exp = Exp::coercion(exp, ty.clone()),
                    Tk::Array(..) | Tk::Func(..) | Tk::Void => {
                        unreachable!()
                    }
                }
                exp.ty = Some(ty.clone());
            } else if ty != exp.ty() {
                panic!("unsupported type coercion: {:?} -> {:?}", exp.ty(), ty);
            }
        }

        // try to fold the expression into a constant value
        if let Some(comptime) = exp.try_fold(symtable) {
            exp = Exp::const_(comptime);
        }

        exp
    }

    /// Try to fold the expression into a constant value.
    pub fn try_fold(&self, symtable: &SymbolTable) -> Option<ComptimeVal> {
        match &self.kind {
            ExpKind::Const(val) => Some(val.clone()),
            ExpKind::Binary(op, lhs, rhs) => {
                let lhs = lhs.try_fold(symtable)?;
                let rhs = rhs.try_fold(symtable)?;

                match op {
                    BinaryOp::Add => Some(lhs + rhs),
                    BinaryOp::Sub => Some(lhs - rhs),
                    BinaryOp::Mul => Some(lhs * rhs),
                    BinaryOp::Div => Some(lhs / rhs),
                    BinaryOp::Mod => Some(lhs % rhs),
                    BinaryOp::Lt => Some(ComptimeVal::Bool(lhs < rhs)),
                    BinaryOp::Gt => Some(ComptimeVal::Bool(lhs > rhs)),
                    BinaryOp::Le => Some(ComptimeVal::Bool(lhs <= rhs)),
                    BinaryOp::Ge => Some(ComptimeVal::Bool(lhs >= rhs)),
                    BinaryOp::Eq => Some(ComptimeVal::Bool(lhs == rhs)),
                    BinaryOp::Ne => Some(ComptimeVal::Bool(lhs != rhs)),
                    BinaryOp::And => Some(lhs.logical_and(&rhs)),
                    BinaryOp::Or => Some(lhs.logical_or(&rhs)),
                }
            },
            ExpKind::Unary(op, exp) => {
                let exp = exp.try_fold(symtable)?;

                match op {
                    UnaryOp::Neg => Some(-exp),
                    UnaryOp::Not => Some(!exp),
                    UnaryOp::Pos => Some(exp),
                }
            },
            ExpKind::FuncCall(_) => None,
            ExpKind::LVal(LVal { ident, indices }) => {
                // TODO✔: what if there are indices? 
                let entry = symtable.lookup(ident).unwrap();
                let val = entry.comptime.as_ref()?.clone();

                // fold indices e.g `arr[2 + 5]` -> `arr[7]`
                let folded_indices: Vec<i64> = indices
                    .iter()
                    .map(|index| {
                        match index.try_fold(symtable)? {
                            ComptimeVal::Int(i) => Some(i),
                            ComptimeVal::Float(f) => Some(f as i64),
                            ComptimeVal::Bool(b) => Some(b as i64),
                            _ => None,
                        }
                    })
                    .collect::<Option<Vec<i64>>>()?;

                // get the value at the folded indices
                // e.g `int a[3] = {1, 2, 3}` 
                // `int b = arr[1]` -> `int b = 3`
                let val = folded_indices.into_iter().try_fold(val, |val, index| {
                    match val {
                        ComptimeVal::List(list) => list.get(index as usize).cloned(),
                        _ => None,
                    }
                })?;

                Some(val)
            },
            ExpKind::InitList(vals) => {
                let vals = vals
                    .iter()
                    .map(|val| val.try_fold(symtable))
                    .collect::<Option<Vec<_>>>()?;

                Some(ComptimeVal::List(vals))
            }
            ExpKind::Coercion(exp) => {
                // Coerce the expression to the target type
                let exp = exp.try_fold(symtable)?;
                match self.ty.as_ref().unwrap().kind() {
                    Tk::Bool => {
                        let exp = match exp {
                            ComptimeVal::Bool(val) => val,
                            ComptimeVal::Int(val) => val != 0,
                            ComptimeVal::Float(val) => val != 0.0,
                            ComptimeVal::Undef(_) | ComptimeVal::List(_) | ComptimeVal::Zero(_) => unreachable!(),

                        };
                        Some(ComptimeVal::bool(exp))
                    }
                    Tk::Int => {
                        let exp = match exp {
                            ComptimeVal::Bool(val) => val as i64,
                            ComptimeVal::Int(val) => val,
                            ComptimeVal::Float(val) => val as i64,
                            ComptimeVal::Undef(_) | ComptimeVal::List(_) | ComptimeVal::Zero(_) => unreachable!(),
                        };
                        Some(ComptimeVal::int(exp))
                    }
                    Tk::Float => {
                        let exp = match exp {
                            ComptimeVal::Bool(val) => val as i32 as f32,
                            ComptimeVal::Int(val) => val as f32,
                            ComptimeVal::Float(val) => val,
                            ComptimeVal::Undef(_) | ComptimeVal::List(_) | ComptimeVal::Zero(_) => unreachable!(),
                        };
                        Some(ComptimeVal::float(exp))
                    }
                    Tk::Void | Tk::Func(..) | Tk::Array(..) | Tk::Pointer(..) => {
                        panic!("unsupported type coercion")
                    }
                }
            }
        }
    }
}



// Implement the `Display` trait for the AST structs.
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
            },
            ComptimeVal::Undef(ty) => write!(f, "undef({})", ty),
            ComptimeVal::Zero(ty) => write!(f, "zero({})", ty),
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
