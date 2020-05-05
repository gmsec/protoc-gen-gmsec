NAME := protoc-gen-gmsec
build:
	go build -o $(NAME) main.go 
	cp -rf ./protoc-gen-gmsec $(GOPATH)//bin/protoc-gen-gmsec
source_install:
	./proto_install.sh
install:
	./proto_install.sh