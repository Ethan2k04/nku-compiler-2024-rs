#!/bin/bash

# 进入测试目录
TEST_DIR="./tests/testcase/"
OUTPUT_DIR="./test_results"

# 创建保存结果的目录
mkdir -p "$OUTPUT_DIR"

# 遍历所有的 .sy 文件进行测试
for sy_file in $(find "$TEST_DIR" -name "*.sy"); do
    # 获取文件名（不带目录和扩展名）
    base_name=$(basename "$sy_file" .sy)

    # 运行编译器，假设编译器的可执行文件名是 `nkucc`
    # 并将输出保存到对应的 .out 文件中
    RUSTFLAGS="-A warnings" cargo run -- -i "$sy_file" > "$OUTPUT_DIR/$base_name.out" 2> "$OUTPUT_DIR/$base_name.err"

    # 检查编译器是否成功运行
    if [ $? -eq 0 ]; then
        echo "Test $base_name passed"
    else
        echo "Test $base_name failed, check $OUTPUT_DIR/$base_name.err for details"
    fi
done