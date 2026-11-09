# protoc-gen-gmsec
gmsec protoc generate tools

# install

> 注意:必须在仓库里从源码构建。go.mod 里有一行
> `replace google.golang.org/protobuf => ./protobuf@v1.36.11`,
> 这个 fork 才是生成 `jsonschema_description` 标签的关键。
> 用 `go install github.com/gmsec/protoc-gen-gmsec@latest` 会拉官方的
> protobuf,插件能跑但生成的代码会少字段标签。

- 1.install protoc
- 2.install 

```
make install 
```

or 

```
make source_install
```

# build 

 - protoc --proto_path="{proto path}" --gmsec_out=plugins=gmsec:{out path} hello.proto
 
- example

```
protoc --proto_path="./apidoc/proto/hello/" --gmsec_out=plugins=gmsec:./rpc/ hello.proto
```

# 测试

示例 proto 放在 `example/` 下,生成的 `*.pb.go` 会**同时**由本插件产出(内置 protoc-gen-go),
所以只需要 `--gmsec_out`,不需要再传 `--go_out`。

```
protoc --proto_path=./example --plugin=protoc-gen-gmsec=./protoc-gen-gmsec.exe \
       --gmsec_out=plugins=gmsec:./example example/test.proto
```