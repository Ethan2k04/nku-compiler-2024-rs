//! Symbol table for the frontend.
use std::collections::HashMap;

use super::ast::*;
use super::types::{Type, TypeKind as Tk};
use super::irgen::IrGenResult;


/// Symbol table entry.
/// This is used to store information about a symbol in the symbol table.
#[derive(Debug)]
pub struct SymbolEntry {
    /// Type of the symbol.
    pub ty: Type,
    /// The possible compile time value of the symbol.
    pub comptime: Option<ComptimeVal>,
    // /// The IR value of the symbol.
    /// Its generated during IR generation.
    pub ir_value: Option<IrGenResult>,
}

impl SymbolEntry {
    /// Create a new symbol entry from a type.
    pub fn from_ty(ty: Type) -> Self {
        Self {
            ty,
            comptime: None,
            ir_value: None,
        }
    }
}

/// Symbol table.
/// This is used to store information about symbols in the program.
#[derive(Default)]
pub struct SymbolTable {
    /// Stack of scopes.
    /// Each scope has its own hashmap of symbols.
    stack: Vec<HashMap<String, SymbolEntry>>,

    /// The current return type of the function.
    pub curr_ret_ty: Option<Type>,
}

impl SymbolTable {
    /// Enter a new scope.
    pub fn enter_scope(&mut self) { self.stack.push(HashMap::default()); }

    /// Leave the current scope.
    pub fn leave_scope(&mut self) { self.stack.pop(); } 

    /// Insert a symbol into the current scope.
    pub fn insert(&mut self, name: impl Into<String>, entry: SymbolEntry) {
        self.stack.last_mut().unwrap().insert(name.into(), entry);
    }

    /// Insert a symbol into the `upper`-th scope from the current scope.
    pub fn insert_upper(&mut self, name: impl Into<String>, entry: SymbolEntry, upper: usize) {
        self.stack
            .iter_mut()
            .rev()
            .nth(upper)
            .unwrap()
            .insert(name.into(), entry);
    }

    /// Lookup a symbol in the symbol table.
    pub fn lookup(&self, name: &str) -> Option<&SymbolEntry> {
        for scope in self.stack.iter().rev() {
            if let Some(entry) = scope.get(name) {
                return Some(entry);
            }
        }
        None
    }

    /// Lookup a symbol in the symbol table.
    pub fn lookup_mut(&mut self, name: &str) -> Option<&mut SymbolEntry> {
        for scope in self.stack.iter_mut().rev() {
            if let Some(entry) = scope.get_mut(name) {
                return Some(entry);
            }
        }
        None
    }

    /// Register SysY library functions to the symbol table.
    pub fn register_sysylib(&mut self) {
        // TODO: Register SysY library functions to the symbol table
    }
}