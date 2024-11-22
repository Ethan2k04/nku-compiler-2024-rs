# NKU Compiler 2024 (Rust)

本框架由 2024 年编译系统实现赛 RISC-V 赛道作品改编而来，原代码仓库为：

[https://github.com/JuniMay/orzcc](https://github.com/JuniMay/orzcc)

## Testcase Reference

2023编译系统实现赛官方样例：[https://gitlab.eduxiji.net/nscscc/compiler2023](https://gitlab.eduxiji.net/nscscc/compiler2023)

北京大学编译原理实验课样例：[https://github.com/pku-minic/awesome-sysy](https://github.com/pku-minic/awesome-sysy)

洛谷P3380题解：[https://www.luogu.com.cn/article/55088clb](https://www.luogu.com.cn/article/55088clb)

## Implementation

- [x] **词法/语法分析**
  - 负责将源代码转化为语法树，识别语言的基本结构。
- [x] **中间代码生成**
  - 生成平台无关的中间代码，以便后续优化和目标代码生成。
- [ ] **代码优化**
  - 通过消除冗余代码和改进算法，提高最终生成代码的执行效率。
- [ ] **目标代码生成**
  - 将优化后的中间代码转化为特定平台的机器代码。
- [ ] **错误处理与调试**
  - 实现全面的错误检测与调试信息输出，提升开发者体验。

## Dependencies

- **thiserror**: `1.0.61`
- **hexponent**: `0.3.1`
- **lalrpop**: `0.20.2`

## Installation

1. 克隆仓库：
   ```bash
   git clone https://github.com/Ethan2k04/nku-compiler-2024-rs.git
   cd src

## About Us

我们是热爱编译器的 Rustaceans ✨，致力于构建一个高效、灵活的编译器工具链。

我们的团队由经验丰富的开发者和编程语言爱好者组成。

![nku_compiler_logo](https://github.com/user-attachments/assets/93b70721-6225-41f5-96a4-3b04f8a43712)

*如果你有任何问题，欢迎提交pr~*
