# protoc-gen-gmsec
gmsec protoc generate tools

# install

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

