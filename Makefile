NAME := protoc-gen-gmsec
# GOPATH/bin 必须通过 go env 取:make 里 $(GOPATH) 在未导出该环境变量时为空,
# 历史写法 `cp ./protoc-gen-gmsec $(GOPATH)/bin` 会退化成 `cp ./protoc-gen-gmsec /bin`,
# 以 root 执行时直接污染系统目录。
GOBIN := $(shell go env GOBIN)
ifeq ($(GOBIN),)
GOBIN := $(shell go env GOPATH)/bin
endif

.PHONY: build install source_install windows mac linux clean

build:
	go build -o $(NAME) .
	cp -f ./$(NAME) "$(GOBIN)/"
source_install:
	./proto_install.sh
install:
	./proto_install.sh
windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o $(NAME).exe .
mac:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o $(NAME) .
linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o $(NAME) .
clean:
	rm -f $(NAME) $(NAME).exe