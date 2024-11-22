//! Function definition and related types.
use std::fmt;

use super::block::Block;
use super::context::Context;
use super::ty::Ty;
use super::value::Value;
use crate::infra::linked_list::LinkedListContainer;
use crate::infra::storage::{Arena, ArenaPtr, GenericPtr};

pub struct FuncData {
    pub(super) self_ptr: Func,
    name: String,
    params: Vec<Value>,
    ret_ty: Ty,
    kind: FuncKind,

    head: Option<Block>,
    tail: Option<Block>,
    // TODO✔: Distinguish `define` and `declare`.
}

pub enum FuncKind {
    Define,
    Declare,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct Func(GenericPtr<FuncData>);

pub struct DisplayFunc<'ctx> {
    ctx: &'ctx Context,
    func: Func,
}

impl Func {
    pub fn new(ctx: &mut Context, name: String, ret_ty: Ty) -> Self {
        ctx.alloc_with(|self_ptr| FuncData {
            self_ptr,
            name,
            params: Vec::new(),
            ret_ty,
            head: None,
            tail: None,
            kind: FuncKind::Define,
        })
    }

    pub fn declare(ctx: &mut Context, name: String, ret_ty: Ty) -> Self {
        ctx.alloc_with(|self_ptr| FuncData {
            self_ptr,
            name,
            params: Vec::new(),
            ret_ty,
            head: None,
            tail: None,
            kind: FuncKind::Declare,
        })
    }

    pub fn kind(self, ctx: &Context) -> &FuncKind {
        &self.deref(ctx).kind
    }

    pub fn add_param(self, ctx: &mut Context, ty: Ty) -> Value {
        let index = self.deref(ctx).params.len() as u32;
        let param = Value::new_param(ctx, self, ty, index);
        self.deref_mut(ctx).params.push(param);
        param
    }

    pub fn name(self, ctx: &Context) -> &str { &self.deref(ctx).name }

    pub fn params(self, ctx: &Context) -> &[Value] { &self.deref(ctx).params }

    pub fn ret_ty(self, ctx: &Context) -> Ty { self.deref(ctx).ret_ty }

    pub fn display(self, ctx: &Context) -> DisplayFunc { DisplayFunc { ctx, func: self } }
}

impl fmt::Display for DisplayFunc<'_> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let prefix = match *self.func.kind(self.ctx) {
            FuncKind::Define => "define",
            FuncKind::Declare => "declare",
        };

        // 写入函数声明部分
        write!(
            f,
            "{} {} @{}(",
            prefix,
            self.func.ret_ty(self.ctx).display(self.ctx),
            self.func.name(self.ctx)
        )?;

        // 写入参数列表
        for (i, param) in self.func.params(self.ctx).iter().enumerate() {
            if i != 0 {
                write!(f, ", ")?;
            }
            // 不仅要打印类型，还要打印参数名
            write!(f, "{}", param.display(self.ctx, true))?;
        }

        // 根据函数类型决定是否输出函数体
        match *self.func.kind(self.ctx) {
            FuncKind::Declare => {
                // declare
                write!(f, ")")
            }
            FuncKind::Define => {
                // define
                write!(f, ") {{")?;
                for block in self.func.iter(self.ctx) {
                    write!(f, "\n{}", block.display(self.ctx))?;
                }
                write!(f, "\n}}")
            }
        }.expect("Write failed");
        
        Ok(())
    }
}

impl ArenaPtr for Func {
    type Arena = Context;
    type Data = FuncData;
}

impl Arena<Func> for Context {
    fn alloc_with<F>(&mut self, f: F) -> Func
    where
        F: FnOnce(Func) -> FuncData,
    {
        Func(self.funcs.alloc_with(|ptr| f(Func(ptr))))
    }

    fn try_dealloc(&mut self, ptr: Func) -> Option<FuncData> { self.funcs.try_dealloc(ptr.0) }

    fn try_deref(&self, ptr: Func) -> Option<&FuncData> { self.funcs.try_deref(ptr.0) }

    fn try_deref_mut(&mut self, ptr: Func) -> Option<&mut FuncData> {
        self.funcs.try_deref_mut(ptr.0)
    }
}

impl LinkedListContainer<Block> for Func {
    type Ctx = Context;

    fn head(self, ctx: &Self::Ctx) -> Option<Block> { self.try_deref(ctx).unwrap().head }

    fn tail(self, ctx: &Self::Ctx) -> Option<Block> { self.try_deref(ctx).unwrap().tail }

    fn set_head(self, ctx: &mut Self::Ctx, head: Option<Block>) {
        self.try_deref_mut(ctx).unwrap().head = head;
    }

    fn set_tail(self, ctx: &mut Self::Ctx, tail: Option<Block>) {
        self.try_deref_mut(ctx).unwrap().tail = tail;
    }
}
