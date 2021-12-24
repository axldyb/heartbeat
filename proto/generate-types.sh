#!/bin/sh

echo "Generating types..."

rm -rf ../rest-api/proto
rm -rf ../server/proto
rm -rf ../app/HeartbeatKit/Sources/HeartbeatKit/proto

mkdir ../app/HeartbeatKit/Sources/HeartbeatKit/proto

./node_modules/.bin/proto-loader-gen-types --longs=String --enums=String --defaults --oneofs --grpcLib=@grpc/grpc-js --outDir=../rest-api/proto ./*.proto
./node_modules/.bin/proto-loader-gen-types --longs=String --enums=String --defaults --oneofs --grpcLib=@grpc/grpc-js --outDir=../server/proto ./*.proto

protoc heartbeat.proto \
    --plugin=protoc-gen-grpc=./swift/protoc-gen-swift \
    --plugin=./swift/protoc-gen-swift \
    --experimental_allow_proto3_optional \
    --swift_opt=Visibility=Public \
    --swift_out=../app/HeartbeatKit/Sources/HeartbeatKit/proto

protoc heartbeat.proto \
    --plugin=./swift/protoc-gen-grpc-swift \
    --plugin=protoc-gen-grpc=./swift/protoc-gen-swift \
    --plugin=protoc-gen-grpc=./swift/protoc-gen-grpc-swift \
    --experimental_allow_proto3_optional \
    --swift_out=../app/HeartbeatKit/Sources/HeartbeatKit/proto \
    --swift_opt=Visibility=Public \
    --grpc-swift_out=Client=true,Server=false:../app/HeartbeatKit/Sources/HeartbeatKit/proto

cp ./*.proto ../rest-api/proto
cp ./*.proto ../server/proto