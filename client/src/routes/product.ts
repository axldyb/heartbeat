import { Router } from 'express'
import * as grpcRoutes from './grpc'

// new router
const productRouter = Router()

// routes
productRouter.get('/products', grpcRoutes.listProducts)
productRouter.get('/products/:id', grpcRoutes.readProduct)
productRouter.post('/products', grpcRoutes.createProduct)
productRouter.put('/products/:id', grpcRoutes.updateProduct)
productRouter.delete('/products/:id', grpcRoutes.deleteProduct)

export { productRouter }