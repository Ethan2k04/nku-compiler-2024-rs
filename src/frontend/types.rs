//! Define the types in AST of SysY language.
//! The types are used in the AST and the symbol table.
/// Reference: https://github.com/pku-minic/koopa/blob/master/src/ir/types.rs
/// Reference: https://github.com/JuniMay/orzcc/blob/master/src/frontend/sysy/types.rs


use std::cell::RefCell;
use std::collections::HashMap;
use std::rc::Rc;
use std::{fmt, hash};

// TODO: Implement the `Type` struct here.

// The type in AST
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum TypeKind {
    Void,
    // The boolean type.
    // There is no `bool` type, but the intermediate result might be boolean.
    Bool,
    // The integer type.
    Int,
    // The float type.
    Float,
    // The array type, with the element type and the length.
    Array(Type, usize),
    // The pointer type, a better way to address array decay.
    Pointer(Type),
    // The function type, with params and return type.
    Func(Vec<Type>, Type),
}

// The type in AST
#[derive(Clone, Eq)]
pub struct Type(Rc<TypeKind>);

impl hash::Hash for Type {
    fn hash<H: hash::Hasher>(&self, state: &mut H) { self.0.hash(state) }
}

impl PartialEq for Type {
    // Just compare the pointers
    fn eq(&self, other: &Self) -> bool { Rc::ptr_eq(&self.0, &other.0) }
}

impl fmt::Debug for Type {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result { self.0.fmt(f) }
}

impl fmt::Display for Type {
    /// Display the type.
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self.kind() {
            TypeKind::Void => write!(f, "void"),
            TypeKind::Bool => write!(f, "bool"),
            TypeKind::Int => write!(f, "int"),
            TypeKind::Float => write!(f, "float"),
            TypeKind::Array(t, len) => write!(f, "{}[{}]", t, len),
            TypeKind::Pointer(t) => write!(f, "{}*", t),
            TypeKind::Func(params, ret) => write!(
                f,
                "{}({})",
                ret,
                params
                    .iter()
                    .map(|t| t.to_string())
                    .collect::<Vec<_>>()
                    .join(", ")
            ),
        }
    }
}

impl Type {
    thread_local! {
        /// The pool to implement singleton.
        ///
        /// Reference: https://github.com/pku-minic/koopa/blob/master/src/ir/types.rs
        ///
        /// This is not the only solution. In the implementation of IR, we use
        /// `UniqueArena` to store types.
        static POOL: RefCell<HashMap<TypeKind, Type>> = RefCell::new(HashMap::default());
    }

    /// Create a new type.
    pub fn make(kind: TypeKind) -> Type {
        Self::POOL.with(|pool| {
            let mut pool = pool.borrow_mut();
            if let Some(ty) = pool.get(&kind) {
                ty.clone()
            } else {
                let ty = Type(Rc::new(kind.clone()));
                pool.insert(kind, ty.clone());
                ty
            }
        })
    }

    // Get the kind of the type.
    pub fn kind(&self) -> &TypeKind { &self.0 }

    // Create a new void type.
    pub fn void() -> Self { Self::make(TypeKind::Void) }

    // Create a new boolean type.
    pub fn bool() -> Self { Self::make(TypeKind::Bool) }

    // Create a new integer type.
    pub fn int() -> Self { Self::make(TypeKind::Int) }

    // Create a new float type.
    pub fn float() -> Self { Self::make(TypeKind::Float) }

    // Create a new array type.
    pub fn array(t: Type, len: usize) -> Self { Self::make(TypeKind::Array(t, len)) }

    // Create a new pointer type.
    pub fn pointer(t: Type) -> Self { Self::make(TypeKind::Pointer(t)) }

    // Create a new function type.
    pub fn func(params: Vec<Type>, ret: Type) -> Self { Self::make(TypeKind::Func(params, ret)) }

    // Check if the type is a void type.
    pub fn is_void(&self) -> bool { matches!(self.kind(), TypeKind::Void) }

    // Check if the type is a boolean type.
    pub fn is_bool(&self) -> bool { matches!(self.kind(), TypeKind::Bool) }

    // Check if the type is an integer type.
    pub fn is_int(&self) -> bool { matches!(self.kind(), TypeKind::Int) }

    // Check if the type is a float type.
    pub fn is_float(&self) -> bool { matches!(self.kind(), TypeKind::Float) }

    // Check if the type is an array type.
    pub fn is_array(&self) -> bool { matches!(self.kind(), TypeKind::Array(_, _)) }

    // Check if the type is a pointer type.
    pub fn is_pointer(&self) -> bool { matches!(self.kind(), TypeKind::Pointer(_)) }

    // pub fn is_compatible_with(&self, other: &Type) -> bool {
    //     match (self.kind(), other.kind()) {
    //         (TypeKind::Array(t1, len1), TypeKind::Array(t2, len2)) => {
    //             t1 == t2 && (*len1 == 0 || *len1 == *len2)
    //         }
    //         _ => self == other
    //     }
    // }

    // XXX: Maybe we should add a `is_func` method here.
    // XXX: Maybe we should add a func to get all the dimensions of an array type.

    /// Get the element type and length of an array type.
    /// 
    /// # Panics
    /// 
    /// - Panics if the type is not an array type.
    pub fn unwrap_array(&self) -> (&Type, usize) {
        if let TypeKind::Array(t, len) = self.kind() {
            (t, *len)
        } else {
            panic!("unwrap_array: not an array type: {}", self);
        }
    }

    /// Get the parameters and return type of a function type.
    ///
    /// # Panics
    ///
    /// - Panics if the type is not a function type.
    pub fn unwrap_func(&self) -> (&[Type], &Type) {
        if let TypeKind::Func(params, ret) = self.kind() {
            (params, ret)
        } else {
            panic!("unwrap_func: not a function type: {}", self);
        }
    }

    /// Get the bytewidth of the type.
    pub fn bytewidth(&self) -> usize {
        match self.kind() {
            TypeKind::Void => 0,
            TypeKind::Bool => 1,
            TypeKind::Int => 4,
            TypeKind::Float => 4,
            TypeKind::Array(t, len) => t.bytewidth() * len,
            TypeKind::Pointer(_) => unreachable!(),
            TypeKind::Func(_, _) => unreachable!(),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_type_display() {
        assert_eq!(Type::void().to_string(), "void");
        assert_eq!(Type::bool().to_string(), "bool");
        assert_eq!(Type::int().to_string(), "int");
        assert_eq!(Type::float().to_string(), "float");
        assert_eq!(Type::array(Type::int(), 10).to_string(), "int[10]");
        assert_eq!(Type::pointer(Type::int()).to_string(), "int*");
        assert_eq!(
            Type::func(vec![Type::int(), Type::float()], Type::void()).to_string(),
            "void(int, float)"
        );
    }
}