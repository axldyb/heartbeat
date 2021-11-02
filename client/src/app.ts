import * as express from 'express'
import * as bodyParser from 'body-parser'
import { productRouter } from './routes/product'
import { RouteLoggerMiddleware } from './utils/route-logger-middleware'

const routeLogger = new RouteLoggerMiddleware()

// express
const app = express()
app.use(routeLogger.middlewareFunc)
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

// routes
app.use('/api', productRouter)

// run server
app.listen(3000, () => {
    console.log('API client listing on port 3000')
})
