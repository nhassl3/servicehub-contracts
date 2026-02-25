.PHONY: proto install

.DEFAULT_GOAL := proto

# Proto
PROTO_DIR=./proto
PROTO_OUT=./pkg

install:
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@go install github.com/envoyproxy/protoc-gen-validate@latest

proto:
	@mkdir -p $(PROTO_OUT)
	@protoc \
		--proto_path=$(PROTO_DIR) \
		--proto_path=/usr/include \
		--go_out=$(PROTO_OUT) \
		--go_opt=module=github.com/nhassl3/servicehub \
		--go-grpc_out=$(PROTO_OUT) \
		--go-grpc_opt=module=github.com/nhassl3/servicehub \
		--grpc-gateway_out=$(PROTO_OUT) \
		--grpc-gateway_opt=module=github.com/nhassl3/servicehub \
		--grpc-gateway_opt=generate_unbound_methods=true \
		$(shell find $(PROTO_DIR) -name "*.proto" -not -path "*/googleapis/*")
	@echo "Successfully built protocol buffers code files"