package plugin

import (
	gengo "google.golang.org/protobuf/cmd/protoc-gen-go/internal_gengo"
	"google.golang.org/protobuf/compiler/protogen"
)

// GenerateFile generates a .pb.go file containing Go structs with jsonschema_description tags
func GenerateFile(gen *protogen.Plugin, file *protogen.File) error {
	// 调用gengo.GenerateFile生成基础代码
	gengo.GenerateFile(gen, file)
	return nil
}
