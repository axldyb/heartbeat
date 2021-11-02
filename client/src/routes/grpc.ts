import * as protoLoader from '@grpc/proto-loader'
import { ProtoGrpcType } from '../../proto/product'
import { ProductServiceClient } from '../../proto/product/ProductService'
import * as grpc from '@grpc/grpc-js'
import { Request, Response } from 'express'

function getClient(): ProductServiceClient {
    const packageDefinition = protoLoader.loadSync('./proto/product.proto')
    const proto = (grpc.loadPackageDefinition(packageDefinition) as unknown) as ProtoGrpcType
    const credentials = grpc.credentials.createInsecure() as grpc.ChannelCredentials
    const client = new proto.product.ProductService('server:9090', credentials)
    return client
}

const client = getClient()

// handlers
const listProducts = (req: Request, res: Response) => {
    console.log('list products')
    client.listProducts({}, (err, result) => {
        console.log('products: ' + JSON.stringify(result, null, 2))
        console.log('products: ' + JSON.stringify(err, null, 2))
        res.json(result)
    })
}
const readProduct = (req: Request, res: Response) => {
    res.json({ status: 'not implemented' })
}
const createProduct = (req: Request, res: Response) => {
    res.json({ status: 'not implemented' })
}
const updateProduct = (req: Request, res: Response) => {
    res.json({ status: 'not implemented' })
}
const deleteProduct = (req: Request, res: Response) => {
    res.json({ status: 'not implemented' })
}

export {
    listProducts,
    readProduct,
    createProduct,
    updateProduct,
    deleteProduct,
}