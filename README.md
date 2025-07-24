# `traderkit`

## Generating gRPC code

Dependencies installed via homebrew:

- `protoc`
- `swift-protobuf` (This is also included as a package dependency, it may be possible to build and use it from here instead)

Xcode Package dependencies:

- `grpc-swift-2` (>2.1)
- `grpc-swift-protobuf` (>2.0)
- `SwiftProtobuf` (>1.30)

Define `*.proto` files in `traderkit/apis` and run:

```shell
protoc --swift_out=. filename
```

This will generate a `filename.pb.swift` file in the same directory as the `*.proto` file. 
These are not committed to version control.

### Questions

1. Can we use the local package dependency for `SwiftProtobuf` with `protoc` instead of using homebrew-installed `swift-protobuf`?
2. Meaning of the `swift_out` versus `grpc-swift_out` options in `protoc`?
3. How does this approach differ from using `protoc swift build`? Is a SwiftPM build approach better? Can we define a command to build protobuf files as part of the Xcode build process?
4. Does the `grpc-swift-proto-generator-config.json` file get used when generation is called via `protoc`?

### Notes

Value of `grpc-swift-proto-generator-config.json` before deletion:

```json
{
  "generate": {
    "clients": true,
    "servers": false,
    "messages": true
  },
  "generatedSource": {
    "accessLevelOnImports": false,
    "accessLevel": "internal"
  },
  "protoc": {
    "executablePath": "/opt/homebrew/bin/protoc",
    "importPaths": []
  }
}
```

Transports are considered "expensive" and should be maintained throughout the application lifetime:

https://swiftpackageindex.com/grpc/grpc-swift-2/2.1.0/documentation/grpccore/clienttransport

> A typical transport implementation will establish and maintain connections to a server (or servers) and manage these over time, potentially closing idle connections and creating new ones on demand. As such transports can be expensive to create and as such are intended to be used as long-lived objects which exist for the lifetime of your application.