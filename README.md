# Ethan2k04 branch

## 使用方式

测试中间代码生成请用下面的指令：

`cargo run -- -o test src/test.sy --emit-ast ast --emit-llvm-ir ir.ll`

如果很不幸您的电脑被植入了clang，您也可以使用下面的指令生成.S汇编文件：

`clang -S ir.ll -o test.s`

## 碎碎念
我们必须认为西西弗斯是幸福的, 所以我选 **Rust**

![](assets/fun.jpg)
