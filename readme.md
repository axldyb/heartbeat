# Heartbeat
Heartbeat is a demo project I created to experiment with gRPC. The idea is a simple server accepting heartbeats, alive messages, from clients.

# protoc
To generate Protocol Buffer support code I used `protoc` plugins. The script `/proto/generate-types.sh` is used every time we make changes to the `heartbeat.proto` file. This will update the generated types and services for the different applications.

For the server and API applications I used the `proto-loader` node package.

The plugin for Swift is included [here](https://github.com/grpc/grpc-swift#getting-the-protoc-plugins). I fetched it useing `homebrew` and added the plugin to the repo under `/proto/swift`.
## Up and running
For the first run you may run `$ docker-compose up -d postgres` first to initialize the Postgres database.

Then you can use the `up.sh` script to start all containers.
There's also a `down.sh` to shut down all containers.

## Environment
To set up the desired environment copy the `.env.example`, modify and name it `.env`.

## iOS app

Installed the GRPC-Swift package using Xcode 11 package manager.
[https://github.com/grpc/grpc-swift](https://github.com/grpc/grpc-swift)

Followed the example here to get started:
https://github.com/grpc/grpc-swift/blob/main/Sources/Examples/HelloWorld/Client/main.swift
https://medium.com/swift2go/building-grpc-client-ios-swift-note-taking-app-6133c7d74644