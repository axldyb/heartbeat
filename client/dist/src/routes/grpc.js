"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteProduct = exports.updateProduct = exports.createProduct = exports.readProduct = exports.listProducts = void 0;
const protoLoader = require("@grpc/proto-loader");
const grpc = require("@grpc/grpc-js");
function getClient() {
    const packageDefinition = protoLoader.loadSync('./proto/product.proto');
    const proto = grpc.loadPackageDefinition(packageDefinition);
    const credentials = grpc.credentials.createInsecure();
    const client = new proto.product.ProductService('0.0.0.0:9090', credentials);
    return client;
}
const client = getClient();
// handlers
const listProducts = (req, res) => {
    console.log('list products');
    client.listProducts({}, (err, result) => {
        console.log('products: ' + JSON.stringify(result, null, 2));
        console.log('products: ' + JSON.stringify(err, null, 2));
        res.json(result);
    });
};
exports.listProducts = listProducts;
const readProduct = (req, res) => {
    console.log('read product');
    client.waitForReady(5000, (error) => {
        console.error('error read product: ' + error);
    });
    res.json({ status: 'not implemented' });
};
exports.readProduct = readProduct;
const createProduct = (req, res) => {
    res.json({ status: 'not implemented' });
};
exports.createProduct = createProduct;
const updateProduct = (req, res) => {
    res.json({ status: 'not implemented' });
};
exports.updateProduct = updateProduct;
const deleteProduct = (req, res) => {
    res.json({ status: 'not implemented' });
};
exports.deleteProduct = deleteProduct;
//# sourceMappingURL=grpc.js.map