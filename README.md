# Ethan2k04 branch

## 使用方式

测试中间代码生成请用下面的指令：

`cargo run -- -o test src/test.sy --emit-ast ast --emit-llvm-ir ir.ll`

如果很不幸您的虚拟机被被植入了clang-15，您也可以使用下面的指令生成.S汇编文件：

`clang-15 -mllvm -opaque-pointers -fno-addrsig -S --target=riscv64-linux-gnu-gcc -mabi=lp64d ir.ll -o test.s`

生成可执行文件请使用下面的指令：

`riscv64-linux-gnu-gcc -march=rv64gc test.s -L./tests/sysy-runtime-lib -lsylib -o test`

最后，您可以通过下面的指令对可执行文件进行测试：

`qemu-riscv64 -cpu rv64,zba=true,zbb=true -L /usr/riscv64-linux-gnu ./test`

## 碎碎念
我们必须认为西西弗斯是幸福的, 所以我选 **Rust**

![](assets/fun.jpg)
