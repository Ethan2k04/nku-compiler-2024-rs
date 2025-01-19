use std::fmt;

use super::block::MBlock;
use super::func::MFunc;
use super::func::MLabel;
use super::context::MContext;
use super::imm::Imm12;
use super::operand::MemLoc;
use super::regs::{self, Reg, RegKind};
use crate::infra::linked_list::LinkedListNode;
use crate::infra::storage::{Arena, ArenaPtr, GenericPtr};

/// The data of the machine instruction.
pub struct MInstData {
    pub kind: MInstKind,
    next: Option<MInst>,
    prev: Option<MInst>,
    parent: Option<MBlock>,
}

/// The machine instruction.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct MInst(GenericPtr<MInstData>);

/// Kinds of machine instructions.
///
/// The instructions are classified with its format. This classification is
/// derived from cranelift.
pub enum MInstKind {
    /// ALU instructions with two registers (rd and rs) and an immediate.
    AluRRI {
        op: AluOpRRI,
        rd: Reg,
        rs: Reg,
        imm: Imm12,
    },
    /// ALU instructions with three registers (rd, and two rs-s).
    AluRRR {
        op: AluOpRRR,
        rd: Reg,
        rs1: Reg,
        rs2: Reg,
    },
    /// Float ALU instructions with three registers (rd, and two rs-s).
    FpAluRRR {
        op: FpAluOpRRR,
        rd: Reg,
        rs1: Reg, 
        rs2: Reg,
    },
    /// Load instructions.
    Load { op: LoadOp, rd: Reg, loc: MemLoc },
    /// Store instructions.
    Store { op: StoreOp, rs: Reg, loc: MemLoc },
    /// Load immediate pseudo instruction.
    Li { rd: Reg, imm: u64 },
    /// Jump instructions.
    J { target: MBlock },
    /// Branch instructions
    Br {
        op: BrOp,
        rs1: Reg,
        rs2: Reg,
        target: MBlock,
    },
    /// Call instructions.
    Call {
        target: MFunc,
    },
    /// Return instructions.
    Ret,
    /// Load address pseudo instruction.
    La { rd: Reg, symbol: MLabel },
    // TODO: add more instructions as you need.
}

#[derive(Copy, Clone)]
pub enum BrOp {
    Beq,  // Branch if equal
    Bne,  // Branch if not equal
    Blt,  // Branch if less than (signed)
    Bge,  // Branch if greater than or equal (signed) 
    Bltu, // Branch if less than (unsigned)
    Bgeu, // Branch if greater than or equal (unsigned)
}

impl fmt::Display for BrOp {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            BrOp::Beq => write!(f, "beq"),
            BrOp::Bne => write!(f, "bne"),
            BrOp::Blt => write!(f, "blt"),
            BrOp::Bge => write!(f, "bge"),
            BrOp::Bltu => write!(f, "bltu"),
            BrOp::Bgeu => write!(f, "bgeu"),
        }
    }
}

#[derive(Copy, Clone)]
pub enum LoadOp {
    Lb,
    Lh,
    Lw,
    Ld,
    Lbu,
    Lhu,
    Lwu,
    Flw,
    Fld,
}

impl fmt::Display for LoadOp {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            LoadOp::Lb => write!(f, "lb"),
            LoadOp::Lh => write!(f, "lh"),
            LoadOp::Lw => write!(f, "lw"),
            LoadOp::Ld => write!(f, "ld"),
            LoadOp::Lbu => write!(f, "lbu"),
            LoadOp::Lhu => write!(f, "lhu"),
            LoadOp::Lwu => write!(f, "lwu"),
            LoadOp::Flw => write!(f, "flw"),
            LoadOp::Fld => write!(f, "fld"),
        }
    }
}

#[derive(Copy, Clone)]
pub enum StoreOp {
    Sb,
    Sh,
    Sw,
    Sd,
    Fsw,
    Fsd,
}

impl fmt::Display for StoreOp {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            StoreOp::Sb => write!(f, "sb"),
            StoreOp::Sh => write!(f, "sh"),
            StoreOp::Sw => write!(f, "sw"),
            StoreOp::Sd => write!(f, "sd"),
            StoreOp::Fsw => write!(f, "fsw"),
            StoreOp::Fsd => write!(f, "fsd"),
        }
    }
}

#[derive(Copy, Clone)]
pub enum AluOpRRI {
    Addi,
    Addiw,
    Slli,
    Slliw,
    Srli,
    Srliw,
    Srai,
    Sraiw,
    Xori,
    Ori,
    Andi,
    Slti,
    Sltiu,
}

impl fmt::Display for AluOpRRI {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            AluOpRRI::Addi => write!(f, "addi"),
            AluOpRRI::Addiw => write!(f, "addiw"),
            AluOpRRI::Slli => write!(f, "slli"),
            AluOpRRI::Slliw => write!(f, "slliw"),
            AluOpRRI::Srli => write!(f, "srli"),
            AluOpRRI::Srliw => write!(f, "srliw"),
            AluOpRRI::Srai => write!(f, "srai"),
            AluOpRRI::Sraiw => write!(f, "sraiw"),
            AluOpRRI::Xori => write!(f, "xori"),
            AluOpRRI::Ori => write!(f, "ori"),
            AluOpRRI::Andi => write!(f, "andi"),
            AluOpRRI::Slti => write!(f, "slti"),
            AluOpRRI::Sltiu => write!(f, "sltiu"),
        }
    }
}

#[derive(Copy, Clone)]
pub enum AluOpRRR {
    // rv64gc
    Add,
    Addw,
    Sub,
    Subw,
    Sll,
    Sllw,
    Srl,
    Srlw,
    Sra,
    Sraw,
    Xor,
    Or,
    And,
    Slt,
    Sltu,
    Mul,
    Mulw,
    Mulh,
    Mulhsu,
    Mulhu,
    Div,
    Divw,
    Divu,
    Divuw,
    Rem,
    Remw,
    Remu,
    Remuw,
    Rew,
}

impl fmt::Display for AluOpRRR {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            AluOpRRR::Add => write!(f, "add"),
            AluOpRRR::Addw => write!(f, "addw"),
            AluOpRRR::Sub => write!(f, "sub"),
            AluOpRRR::Subw => write!(f, "subw"),
            AluOpRRR::Sll => write!(f, "sll"),
            AluOpRRR::Sllw => write!(f, "sllw"),
            AluOpRRR::Srl => write!(f, "srl"),
            AluOpRRR::Srlw => write!(f, "srlw"),
            AluOpRRR::Sra => write!(f, "sra"),
            AluOpRRR::Sraw => write!(f, "sraw"),
            AluOpRRR::Xor => write!(f, "xor"),
            AluOpRRR::Or => write!(f, "or"),
            AluOpRRR::And => write!(f, "and"),
            AluOpRRR::Slt => write!(f, "slt"),
            AluOpRRR::Sltu => write!(f, "sltu"),
            AluOpRRR::Mul => write!(f, "mul"),
            AluOpRRR::Mulw => write!(f, "mulw"),
            AluOpRRR::Mulh => write!(f, "mulh"),
            AluOpRRR::Mulhsu => write!(f, "mulhsu"),
            AluOpRRR::Mulhu => write!(f, "mulhu"),
            AluOpRRR::Div => write!(f, "div"),
            AluOpRRR::Divw => write!(f, "divw"),
            AluOpRRR::Divu => write!(f, "divu"),
            AluOpRRR::Divuw => write!(f, "divuw"),
            AluOpRRR::Rem => write!(f, "rem"),
            AluOpRRR::Remw => write!(f, "remw"),
            AluOpRRR::Remu => write!(f, "remu"),
            AluOpRRR::Remuw => write!(f, "remuw"),
            AluOpRRR::Rew => write!(f, "rew"),
        }
    }
}

// TODO: add more instruction kinds as you need.
pub enum FpAluOpRRR {
    Fadd,  // f[w]add.s/d
    Fsub,  // f[w]sub.s/d 
    Fmul,  // f[w]mul.s/d
    Fdiv,  // f[w]div.s/d
    Fsgnj, // fsgnj.s/d
    Fsgnjn,// fsgnjn.s/d 
    Fsgnjx,// fsgnjx.s/d
    Fmin,  // fmin.s/d
    Fmax,  // fmax.s/d
    Feq,   // feq.s/d
    Flt,   // flt.s/d 
    Fle,   // fle.s/d
}

impl fmt::Display for FpAluOpRRR {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            FpAluOpRRR::Fadd => write!(f, "fadd.s"),
            FpAluOpRRR::Fsub => write!(f, "fsub.s"),
            FpAluOpRRR::Fmul => write!(f, "fmul.s"),
            FpAluOpRRR::Fdiv => write!(f, "fdiv.s"),
            FpAluOpRRR::Fsgnj => write!(f, "fsgnj.s"),
            FpAluOpRRR::Fsgnjn => write!(f, "fsgnjn.s"),
            FpAluOpRRR::Fsgnjx => write!(f, "fsgnjx.s"),
            FpAluOpRRR::Fmin => write!(f, "fmin.s"),
            FpAluOpRRR::Fmax => write!(f, "fmax.s"),
            FpAluOpRRR::Feq => write!(f, "feq.s"),
            FpAluOpRRR::Flt => write!(f, "flt.s"),
            FpAluOpRRR::Fle => write!(f, "fle.s"),
        }
    }
}

pub struct DisplayMInst<'a> {
    mctx: &'a MContext,
    inst: MInst,
}


impl MInst {
    pub fn kind(self, mctx: &MContext) -> &MInstKind { &self.deref(mctx).kind }

    pub fn kind_mut(self, mctx: &mut MContext) -> &mut MInstKind { &mut self.deref_mut(mctx).kind }

    pub fn display(self, mctx: &MContext) -> DisplayMInst { DisplayMInst { mctx, inst: self } }

    // XXX: These instruction creation methods are just for demonstration.
    // You can refactor them as you need.

    /// Create a new `li` instruction.
    ///
    /// imm: The immediate value.
    ///
    /// Returns (inst, rd).
    pub fn li(mctx: &mut MContext, imm: u64) -> (Self, Reg) {
        let rd = mctx.new_vreg(RegKind::General).into();
        let kind = MInstKind::Li { rd, imm };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        let inst = mctx.alloc(data);
        (inst, rd)
    }

    pub fn build_li(mctx: &mut MContext, rd: Reg, imm: u64) -> Self {
        let kind = MInstKind::Li { rd, imm };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    /// Create a new `load` instruction.
    ///
    /// op: LoadOp
    /// loc: The memory location.
    ///
    /// Returns (inst, rd).
    pub fn load(mctx: &mut MContext, op: LoadOp, loc: MemLoc) -> (Self, Reg) {
        let rd = mctx.new_vreg(RegKind::General).into();
        let kind = MInstKind::Load { op, rd, loc };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        let inst = mctx.alloc(data);
        (inst, rd)
    }

    pub fn build_load(mctx: &mut MContext, op: LoadOp, rd: Reg, loc: MemLoc) -> Self {
        let kind = MInstKind::Load { op, rd, loc };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    /// Create a new `store` instruction.
    ///
    /// op: StoreOp
    /// rs: The source register.
    /// loc: The memory location.
    ///
    /// Returns the instruction.
    pub fn store(mctx: &mut MContext, op: StoreOp, rs: Reg, loc: MemLoc) -> Self {
        let kind = MInstKind::Store { op, rs, loc };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    pub fn call(mctx: &mut MContext, target: MFunc) -> Self {
        let kind = MInstKind::Call { target };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    pub fn ret(mctx: &mut MContext) -> Self {
        mctx.alloc(MInstData {
            kind: MInstKind::Ret,
            next: None,
            prev: None,
            parent: None,
        })
    }

    /// Create a new `alu_rrr` instruction.
    ///
    /// op: AluOpRRI
    /// rs1: The first source register.
    /// rs2: The second source register.
    ///
    /// Returns (inst, rd).
    pub fn alu_rrr(mctx: &mut MContext, op: AluOpRRR, rs1: Reg, rs2: Reg) -> (Self, Reg) {
        let rd = mctx.new_vreg(RegKind::General).into();
        let kind = MInstKind::AluRRR { op, rd, rs1, rs2 };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        let inst = mctx.alloc(data);
        (inst, rd)
    }

    pub fn build_alu_rrr(mctx: &mut MContext, op: AluOpRRR, rd: Reg, rs1: Reg, rs2: Reg) -> Self {
        let kind = MInstKind::AluRRR { op, rd, rs1, rs2 };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    /// Create a new `alu_rri` instruction.
    ///
    /// op: AluOpRRI
    /// rs: The source register.
    /// imm: The immediate value.
    ///
    /// Returns (inst, rd).
    pub fn alu_rri(mctx: &mut MContext, op: AluOpRRI, rs: Reg, imm: Imm12) -> (Self, Reg) {
        let rd = mctx.new_vreg(RegKind::General).into();
        let kind = MInstKind::AluRRI { op, rd, rs, imm };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        let inst = mctx.alloc(data);
        (inst, rd)
    }

    /// Create a new `alu_rri` instruction using raw values.
    /// This is useful when you want to create an instruction without allocating
    /// a new register.
    ///
    /// op: AluOpRRI
    /// rd: The destination register.
    /// rs: The source register.
    /// imm: The immediate value.
    ///
    /// Returns the instruction.
    pub fn raw_alu_rri(mctx: &mut MContext, op: AluOpRRI, rd: Reg, rs: Reg, imm: Imm12) -> Self {
        let kind = MInstKind::AluRRI { op, rd, rs, imm };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    /// Creatr a new `jump` instruction.
    ///
    /// target: The target block.
    ///
    /// Returns the instruction.
    pub fn j(mctx: &mut MContext, target: MBlock) -> Self {
        let kind = MInstKind::J { target };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    pub fn br(mctx: &mut MContext, op: BrOp, rs1: Reg, rs2: Reg, target: MBlock) -> Self {
        let kind = MInstKind::Br { op, rs1, rs2, target };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    pub fn build_la(mctx: &mut MContext, rd: Reg, symbol: MLabel) -> Self {
        let kind = MInstKind::La { rd, symbol };
        let data = MInstData {
            kind,
            next: None,
            prev: None,
            parent: None,
        };
        mctx.alloc(data)
    }

    pub fn adjust_offset<F>(self, mctx: &mut MContext, f: F) 
    where
        F: FnOnce(MemLoc) -> Option<MemLoc>,
    {
        let (old_loc, new_loc) = match self.kind(mctx) {
            MInstKind::Load { loc, .. } => (*loc, f(*loc)),
            MInstKind::Store { op, rs, loc } => (*loc, f(*loc)),
            _ => return,
        };

        if new_loc.is_none() {
            return;
        }

        let new_loc = match (old_loc, new_loc.unwrap()) {
            (MemLoc::Slot { .. } | MemLoc::Incoming { .. }, MemLoc::RegOffset { base, offset }) => {
                if Imm12::try_from_i64(offset).is_none() {
                    let t0 = regs::t0();
                    let li = Self::build_li(mctx, t0.into(), offset as u64);
                    self.insert_before(mctx, li).unwrap();
                    let add = Self::build_alu_rrr(mctx, AluOpRRR::Add, t0.into(), base, t0.into());
                    self.insert_before(mctx, add).unwrap();
                    MemLoc::RegOffset {
                        base: t0.into(),
                        offset: 0,
                    }
                } else {
                    MemLoc::RegOffset { base, offset }
                }
            }
            _ => unreachable!()
        };  

        match &mut self.deref_mut(mctx).kind {
            MInstKind::Load { loc, .. } => *loc = new_loc,
            MInstKind::Store { loc, .. } => *loc = new_loc,
            _ => unreachable!(),
        }
    }

    // TODO: add more instruction creation methods as you need.
}

impl fmt::Display for DisplayMInst<'_> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self.inst.deref(self.mctx).kind {
            MInstKind::Li { rd, imm } => write!(f, "li {}, {}", rd, imm),
            MInstKind::Load { op, rd, loc } => {
                let slot = match loc {
                    MemLoc::RegOffset { base, offset } => {
                        format!("{}({})", offset, base)
                    }
                    MemLoc::Slot { offset } => {
                        format!("{}(??? SLOT)", offset)
                    }
                    MemLoc::Incoming { offset } => {
                        format!("{}(??? INCOMING)", offset)
                    }
                };
                write!(f, "{} {}, {}", op, rd, slot)
            }
            MInstKind::Store { op, rs, loc } => {
                let slot = match loc {
                    MemLoc::RegOffset { base, offset } => {
                        format!("{}({})", offset, base)
                    }
                    MemLoc::Slot { offset } => {
                        format!("{}(??? SLOT)", offset)
                    }
                    MemLoc::Incoming { offset } => {
                        format!("{}(??? INCOMING)", offset)
                    }
                };
                write!(f, "{} {}, {}", op, rs, slot)
            }
            MInstKind::AluRRR { op, rd, rs1, rs2 } => write!(f, "{} {}, {}, {}", op, rd, rs1, rs2),
            MInstKind::AluRRI { op, rd, rs, imm } => write!(f, "{} {}, {}, {}", op, rd, rs, imm),
            MInstKind::FpAluRRR {..} => todo!(),
            MInstKind::J { target } => write!(f, "j {}", target.label(self.mctx)),
            MInstKind::Br { op, rs1, rs2, target } => {
                write!(f, "{} {}, {}, {}", op, rs1, rs2, target.label(self.mctx))
            }
            MInstKind::Call { target } => {
                write!(f, "call {}", target.label(self.mctx))
            }
            MInstKind::La { rd, ref symbol } => write!(f, "la {}, {}", rd, symbol),
            MInstKind::Ret => write!(f, "ret"),
            // MInstKind::La { rd, symbol } => write!(f, "la {}, {}", rd, symbol),
            // TODO: implement display for more machine instructions
        }
    }
}

impl ArenaPtr for MInst {
    type Arena = MContext;
    type Data = MInstData;
}

impl LinkedListNode for MInst {
    type Container = MBlock;
    type Ctx = MContext;

    fn next(self, ctx: &Self::Ctx) -> Option<Self> { self.deref(ctx).next }

    fn prev(self, ctx: &Self::Ctx) -> Option<Self> { self.deref(ctx).prev }

    fn set_next(self, arena: &mut Self::Ctx, next: Option<Self>) {
        self.deref_mut(arena).next = next;
    }

    fn set_prev(self, arena: &mut Self::Ctx, prev: Option<Self>) {
        self.deref_mut(arena).prev = prev;
    }

    fn container(self, ctx: &Self::Ctx) -> Option<Self::Container> { self.deref(ctx).parent }

    fn set_container(self, arena: &mut Self::Ctx, container: Option<Self::Container>) {
        self.deref_mut(arena).parent = container;
    }
}

impl Arena<MInst> for MContext {
    fn alloc_with<F>(&mut self, f: F) -> MInst
    where
        F: FnOnce(MInst) -> MInstData,
    {
        MInst(self.insts.alloc_with(|p| f(MInst(p))))
    }

    fn try_deref(&self, ptr: MInst) -> Option<&MInstData> { self.insts.try_deref(ptr.0) }

    fn try_deref_mut(&mut self, ptr: MInst) -> Option<&mut MInstData> {
        self.insts.try_deref_mut(ptr.0)
    }

    fn try_dealloc(&mut self, ptr: MInst) -> Option<MInstData> { self.insts.try_dealloc(ptr.0) }
}
