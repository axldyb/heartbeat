import { Router } from 'express'
import * as grpcRoutes from './grpc'

// new router
const heartbeatsRouter = Router()

// routes
heartbeatsRouter.get('/heartbeats', grpcRoutes.listHeartbeats)
heartbeatsRouter.get('/heartbeats/:id', grpcRoutes.readHeartbeat)
heartbeatsRouter.post('/heartbeats', grpcRoutes.createHeartbeat)

export { heartbeatsRouter }