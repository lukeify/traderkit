.PHONY: protoc

protoc:
	protoc --swift_out=. $(file)

# protoc could also be:
# protoc --plugin=/opt/homebrew/bin/protoc-gen-grpc-swift-2 --grpc-swift_out=. $(file)