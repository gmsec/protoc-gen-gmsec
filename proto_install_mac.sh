#!/bin/bash -x 

version="3.11.4"

# su - xxj -c "qwer"
# download
curl -fLo protobuf.tar.gz https://github.com/protocolbuffers/protobuf/releases/download/v${version}/protoc-${version}-osx-x86_64.zip
mkdir protobuf-${version}
tar -xvf protobuf.tar.gz -C ./protobuf-${version}
cd protobuf-${version}

# install
xattr -c ./bin/protoc # mac 
cp -r ./bin/protoc $GOPATH/bin
cd ../
rm -rf protobuf-${version}/
rm -rf ./protobuf.tar.gz

# install go-grpc
go get -u google.golang.org/grpc
go install github.com/gmsec/protoc-gen-gmsec@master

chmod +x $GOPATH/bin/protoc

echo "SUCCESS"
#end