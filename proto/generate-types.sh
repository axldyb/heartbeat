#!/bin/sh

echo "Generating types..."

rm -rf ../rest-api/proto
rm -rf ../server/proto
rm -rf ../app/Heartbeat/Heartbeat/proto

mkdir ../app/Heartbeat/Heartbeat/proto

./node_modules/.bin/proto-loader-gen-types --longs=String --enums=String --defaults --oneofs --grpcLib=@grpc/grpc-js --outDir=../rest-api/proto ./*.proto
./node_modules/.bin/proto-loader-gen-types --longs=String --enums=String --defaults --oneofs --grpcLib=@grpc/grpc-js --outDir=../server/proto ./*.proto
protoc --plugin=./swift/protoc-gen-swift heartbeat.proto --plugin=protoc-gen-grpc=./swift/protoc-gen-swift --experimental_allow_proto3_optional --swift_out=../app/Heartbeat/Heartbeat/proto
protoc --plugin=./swift/protoc-gen-grpc-swift heartbeat.proto --plugin=protoc-gen-grpc=./swift/protoc-gen-swift --plugin=protoc-gen-grpc=./swift/protoc-gen-grpc-swift --experimental_allow_proto3_optional --swift_out=../app/Heartbeat/Heartbeat/proto --grpc-swift_out=Client=true,Server=false:../app/Heartbeat/Heartbeat/proto

cp ./*.proto ../rest-api/proto
cp ./*.proto ../server/proto