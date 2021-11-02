import * as path from 'path'
import * as protoLoader from '@grpc/proto-loader'
import * as grpc from 'grpc'
import { ProtoGrpcType } from '../proto/product'
import { ProductServiceHandlers } from '../proto/product/ProductService'
import { newProduct } from '../proto/product/newProduct'
import { result } from '../proto/product/result'
import { sendUnaryData, ServerUnaryCall } from '@grpc/grpc-js'
import { ProductId } from '../proto/product/ProductId'
import { Empty } from '../proto/product/Empty'
import { ProductList } from '../proto/product/ProductList'
import { Product } from '../proto/product/Product'

import * as knex from 'knex'

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
}

// knex
const environment = process.env.ENVIRONMENT || 'development'
const config = knexConfig[environment]
const knexClient = knex(config)

const productServer: ProductServiceHandlers = {

    createProduct(call: ServerUnaryCall<newProduct, result>, callback: sendUnaryData<result>) {
        if (call.request) {
            console.log(`(server) create product: ${JSON.stringify(call.request, null, 2)}`)
        }
        callback(null, {
            status: 'OK',
        })
    },

    deleteProduct(call: ServerUnaryCall<ProductId, result>, callback: sendUnaryData<result>) {
        if (call.request) {
            console.log(`(server) delete product: ${JSON.stringify(call.request, null, 2)}`)
        }
        callback(null, {
            status: 'OK',
        })
    },

    async listProducts(call: ServerUnaryCall<Empty, ProductList>, callback: sendUnaryData<ProductList>) {
        if (call.request) {
            console.log(`(server) list products: ${JSON.stringify(call.request, null, 2)}`)
        }
        try {
            console.log('server list products')
            const products = await knexClient('products')
            callback(null, { products: products })
        } catch (err) {
            callback(new Error('Unable to list products: ' + err), null)
        }
    },

    readProduct(call: ServerUnaryCall<ProductId, Product>, callback: sendUnaryData<Product>) {
        if (call.request) {
            console.log(`(server) read product: ${JSON.stringify(call.request, null, 2)}`)
        }
        callback(null, {})
    },

    updateProduct(call: ServerUnaryCall<Product, result>, callback: sendUnaryData<result>) {
        if (call.request) {
            console.log(`(server) update product: ${JSON.stringify(call.request, null, 2)}`)
        }
        callback(null, {
            status: 'OK',
        })
    }
}

function getServer(): grpc.Server {
    const packageDefinition = protoLoader.loadSync('./proto/product.proto')
    const proto = (grpc.loadPackageDefinition(packageDefinition) as unknown) as ProtoGrpcType
    const server = new grpc.Server()
    server.addService(proto.product.ProductService.service, productServer)
    return server
}

const host = '0.0.0.0:9090'
const server = getServer()
server.bindAsync(
    host,
    grpc.ServerCredentials.createInsecure(),
    (err: Error | null, port: number) => {
        if (err) {
            console.error(`Server error: ${err.message}`)
        } else {
            console.log(`Server bound on port: ${port}`)
            server.start()
            console.log(`gRPC server running at http://${host}`)
        }
    }
)
