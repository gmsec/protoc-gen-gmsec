# 实现带有jsonschema_description标签的Go结构体生成

## 问题分析
1. **依赖错误**：当前代码依赖`github.com/gmsec/protoc-gen-gmsec/protobuf/internal/fieldnum`和`genname`等内部包，这些包在新版本中不存在，导致编译失败
2. **需求**：生成带有`jsonschema_description`标签的Go结构体，标签内容来自proto字段注释
3. **当前结构**：使用`gengo.GenerateFile`生成基础代码，再调用`gmsec.GenerateFile`添加额外内容

## 实现方案

### 1. 修改main.go，移除internal_gengo依赖
- 删除对`google.golang.org/protobuf/cmd/protoc-gen-go/internal_gengo`的导入
- 移除`gengo.GenerateFile(gen, f)`调用
- 实现自己的`GenerateFile`函数来生成完整的Go结构体代码

### 2. 实现核心GenerateFile函数
创建新的`generator.go`文件，实现以下功能：
- 使用protogen库直接生成Go结构体
- 遍历所有消息和字段
- 从字段注释中提取描述信息
- 在生成结构体字段标签时添加`jsonschema_description`标签
- 确保生成的文件放在正确的输出位置

### 3. 修复依赖问题
- 更新go.mod，移除对内部包的依赖
- 确保所有导入的包都是公开可用的

### 4. 实现字段注释提取逻辑
- 解析proto字段的LeadingComments
- 提取注释内容，移除//前缀和多余空格
- 将注释内容添加到jsonschema_description标签中

### 5. 测试实现
- 使用test.proto文件测试生成功能
- 验证生成的Go结构体是否包含正确的jsonschema_description标签
- 确保生成的文件放在正确的位置

## 预期结果
运行`protoc --proto_path=../apidoc/proto/ --gmsec_out=plugins=gmsec:./ shares/agent.proto`时，将生成带有以下结构的agent.pb.go文件：
```go
// 用户信息 
type User struct { 
    state         protoimpl.MessageState 
    sizeCache     protoimpl.SizeCache 
    unknownFields protoimpl.UnknownFields 

    // 用户ID 
    UserId string `protobuf:"bytes,1,opt,name=user_id,json=userId,proto3" json:"user_id,omitempty" jsonschema_description:"用户ID"` 
    // 用户名 
    Username string `protobuf:"bytes,2,opt,name=username,proto3" json:"username,omitempty" jsonschema_description:"用户名"` 
}
```

## 实现步骤
1. 创建generator.go文件，实现核心生成逻辑
2. 修改main.go，使用自定义的GenerateFile函数
3. 更新go.mod，修复依赖问题
4. 测试生成功能
5. 确保生成的文件放在正确位置