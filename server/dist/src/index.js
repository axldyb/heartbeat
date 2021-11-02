"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
const protoLoader = require("@grpc/proto-loader");
const grpc = require("grpc");
const knex = require("knex");
const knexConfig = {
    development: {
        client: 'postgresql',
        connection: {
            host: 'postgres',
            user: 'postgres',
            password: 'postgres',
            port: '5432',
            database: 'heartbeat',
        },
        pool: {
            min: 2,
            max: 10,
        },
        migrations: {
            directory: path.join(__dirname, 'db', 'migrations'),
        },
        seeds: {
            directory: path.join(__dirname, 'db', 'seeds'),
        },
    }
};
// knex
const environment = process.env.ENVIRONMENT || 'development';
const config = knexConfig[environment];
const knexClient = knex(config);
const productServer = {
    createProduct(call, callback) {
        if (call.request) {
            console.log(`(server) create product: ${JSON.stringify(call.request, null, 2)}`);
        }
        callback(null, {
            status: 'OK',
        });
    },
    deleteProduct(call, callback) {
        if (call.request) {
            console.log(`(server) delete product: ${JSON.stringify(call.request, null, 2)}`);
        }
        callback(null, {
            status: 'OK',
        });
    },
    listProducts(call, callback) {
        return __awaiter(this, void 0, void 0, function* () {
            if (call.request) {
                console.log(`(server) list products: ${JSON.stringify(call.request, null, 2)}`);
            }
            try {
                console.log('server list products');
                knexClient.raw("SELECT 1").then(() => {
                    console.log("PostgreSQL connected");
                }).catch((e) => {
                    console.log("PostgreSQL not connected");
                    console.error(e);
                });
                const products = yield knexClient('products');
                callback(null, { products: products });
            }
            catch (err) {
                callback(new Error('Unable to list products: ' + err), null);
            }
        });
    },
    readProduct(call, callback) {
        if (call.request) {
            console.log(`(server) read product: ${JSON.stringify(call.request, null, 2)}`);
        }
        callback(null, {});
    },
    updateProduct(call, callback) {
        if (call.request) {
            console.log(`(server) update product: ${JSON.stringify(call.request, null, 2)}`);
        }
        callback(null, {
            status: 'OK',
        });
    }
};
function getServer() {
    const packageDefinition = protoLoader.loadSync('../proto/product.proto');
    const proto = grpc.loadPackageDefinition(packageDefinition);
    const server = new grpc.Server();
    server.addService(proto.product.ProductService.service, productServer);
    return server;
}
const host = '0.0.0.0:9090';
const server = getServer();
server.bindAsync(host, grpc.ServerCredentials.createInsecure(), (err, port) => {
    if (err) {
        console.error(`Server error: ${err.message}`);
    }
    else {
        console.log(`Server bound on port: ${port}`);
        server.start();
        console.log(`gRPC server running at http://${host}`);
    }
});
//# sourceMappingURL=index.js.map