NAME := protoc-gen-gmsec
build:
	go build -o $(NAME) main.go 
	cp -rf ./protoc-gen-gmsec $(GOPATH)/bin
source_install:
	./proto_install.sh
install:
	./proto_install.sh
windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o $(NAME).exe main.go 
mac:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o $(NAME) main.go 
linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o $(NAME) main.go 