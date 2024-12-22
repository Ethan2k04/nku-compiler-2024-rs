#!/bin/bash

# 步骤 1: 生成中间代码
# echo "Step 1: Generating intermediate code..."
# cargo run -- -o test test.sy --emit-ast ast --emit-llvm-ir ir.ll
# if [ $? -ne 0 ]; then
#   echo "Error: Failed to generate intermediate code."
#   exit 1
# fi

# 步骤 2: 使用 clang-15 生成 .S 汇编文件
echo "Step 2: Generating assembly file..."
clang-15 -mllvm -opaque-pointers -fno-addrsig -S --target=riscv64-linux-gnu-gcc -mabi=lp64d ir.ll -o test.s
if [ $? -ne 0 ]; then
  echo "Error: Failed to generate assembly file."
  exit 1
fi

# 步骤 3: 生成可执行文件
echo "Step 3: Generating executable file..."
riscv64-linux-gnu-gcc -march=rv64gc test.s -L./tests/sysy-runtime-lib -lsylib -o test
if [ $? -ne 0 ]; then
  echo "Error: Failed to generate executable file."
  exit 1
fi

# 步骤 4: 测试可执行文件
echo "Step 4: Testing the executable file..."
qemu-riscv64 -cpu rv64,zba=true,zbb=true -L /usr/riscv64-linux-gnu ./test
if [ $? -ne 0 ]; then
  echo "Error: Failed to execute the test."
  exit 1
fi

echo "All steps completed successfully!"
