# NKU Compiler 2024 (Rust)

## **<span style="color: red;">这段文字是红色的</span>**

本框架由 2024 年编译系统实现赛 RISC-V 赛道作品改编而来，原代码仓库为：

[https://github.com/JuniMay/orzcc](https://github.com/JuniMay/orzcc)

## Testcase Reference

2023编译系统实现赛官方样例：[https://gitlab.eduxiji.net/nscscc/compiler2023](https://gitlab.eduxiji.net/nscscc/compiler2023)

北京大学编译原理实验课样例：[https://github.com/pku-minic/awesome-sysy](https://github.com/pku-minic/awesome-sysy)

洛谷P3380题解：[https://www.luogu.com.cn/article/55088clb](https://www.luogu.com.cn/article/55088clb)

## Implementation

- 词法/语法分析
  - 使用lalrpop构造lexer和parser
  - 新增支持的tokens：
      - 乘法（*）e.g. "2 * 4;"
      - 除法（/）e.g. "6 / 3;"
      - 取模（%）e.g. "8 % 3;"
      - 比较运算（<, >, <=, >=）e.g. "return a > b;"

## About Us

我们是热爱Compiler的Rustaceans✨

![nku_compiler_logo](https://github.com/user-attachments/assets/93b70721-6225-41f5-96a4-3b04f8a43712)
