## 实现方案

### 1. 修改文件
- **文件路径**: `e:\xxj\work\workspace\github\xxjwxc\protoc-gen-gmsec\protobuf@v1.36.11\cmd\protoc-gen-go\internal_gengo\main.go`

### 2. 修改位置
- **函数**: `genMessageField` (第453行开始)
- **具体位置**: 在structTags初始化后添加jsonschema_description标签生成逻辑

### 3. 代码修改
在`genMessageField`函数中，找到结构体标签初始化部分（第489-503行），添加以下代码：

```go
tags := structTags{
    {"protobuf", fieldProtobufTagValue(field)},
    {"json", fieldJSONTagValue(field)},
}
// 添加jsonschema_description标签，值为字段的注释
if comment := strings.TrimSpace(string(field.Comments.Leading)); comment != "" {
    // 移除注释前的//
    comment = strings.TrimSpace(strings.TrimPrefix(comment, "//"))
    tags = append(tags, structTags{
        {"jsonschema_description", comment},
    }...)
}
```

### 4. 实现原理
1. **提取字段注释**: 从`field.Comments.Leading`获取字段的前置注释
2. **处理注释**: 去除前后空格和开头的`//`
3. **生成标签**: 将处理后的注释作为`jsonschema_description`标签的值添加到结构体标签中
4. **保持原有逻辑**: 不修改其他生成逻辑，只添加新标签

### 5. 预期效果
生成的Go结构体字段将包含`jsonschema_description`标签，值为proto文件中对应的字段注释

### 6. 验证方法
- 重新构建插件: `go build -o protoc-gen-gmsec.exe main.go`
- 生成测试文件: `protoc --proto_path=./ --plugin=gmsec=./protoc-gen-gmsec.exe --gmsec_out=plugins=gmsec:./ test.proto`
- 检查生成的`.pb.go`文件，确认字段包含`jsonschema_description`标签

### 7. 注意事项
- 只修改protobuf@v1.36.11版本的代码
- 不修改`plugin/generator.go`文件
- 保持原有代码结构不变
- 确保生成的标签格式正确