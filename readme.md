# Heartbeat

## Up and running
For the first run you may run `$ docker-compose up -d postgres` first to initialize the Postgres database.

Then you can use the `up.sh` script to start all containers.
There's also a `down.sh` to shut down all containers.

## Environment
To set up the desired environment copy the `.env.example`, modify and name it `.env`.

## TODO

## iOS app

Installed the GRPC-Swift package using Xcode 11 package manager.
[https://github.com/grpc/grpc-swift](https://github.com/grpc/grpc-swift)

Followed the example here to get started:
https://github.com/grpc/grpc-swift/blob/main/Sources/Examples/HelloWorld/Client/main.swift
https://medium.com/swift2go/building-grpc-client-ios-swift-note-taking-app-6133c7d74644