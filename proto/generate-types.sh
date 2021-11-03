#!/bin/sh

echo "Generating types..."

rm -rf ../client/proto
rm -rf ../server/proto

./node_modules/.bin/proto-loader-gen-types --longs=String --enums=String --defaults --oneofs --grpcLib=@grpc/grpc-js --outDir=../client/proto ./*.proto
./node_modules/.bin/proto-loader-gen-types --longs=String --enums=String --defaults --oneofs --grpcLib=@grpc/grpc-js --outDir=../server/proto ./*.proto

cp ./*.proto ../client/proto
cp ./*.proto ../server/proto