import * as express from 'express'
import * as bodyParser from 'body-parser'
import { heartbeatsRouter } from './routes/heartbeats'
import { RouteLoggerMiddleware } from './utils/route-logger-middleware'

const routeLogger = new RouteLoggerMiddleware()
const cors = require('cors')({ origin: true })

// express
const app = express()
app.use(cors)
app.use(routeLogger.middlewareFunc)
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

// routes
app.use('/api', heartbeatsRouter)

// run server
app.listen(3000, () => {
    console.log('REST API listing on port 3000')
})
