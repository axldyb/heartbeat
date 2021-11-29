# Heartbeat

## Up and running
For the first run you may run `$ docker-compose up -d postgres` first to initialize the Postgres database.

Then you can run the regular 'up' command to start all containers.
Run `$ docker-compose up -d`

## TODO
* Replace knex, use the init sql to create the heartbeat table
* Make volume for postgres database to save data between boots


## iOS app

Installed the GRPC-Swift package using Xcode 11 package manager.
[https://github.com/grpc/grpc-swift](https://github.com/grpc/grpc-swift)

Followed the example here to get started:
https://github.com/grpc/grpc-swift/blob/main/Sources/Examples/HelloWorld/Client/main.swift
https://medium.com/swift2go/building-grpc-client-ios-swift-note-taking-app-6133c7d74644