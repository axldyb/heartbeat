import * as express from 'express'
import * as bodyParser from 'body-parser'
import { heartbeatsRouter } from './routes/heartbeats'
import { RouteLoggerMiddleware } from './utils/route-logger-middleware'

const routeLogger = new RouteLoggerMiddleware()
const cors = require('cors')

const allowedOrigins = ['http://localhost:4200']

// express
const app = express()
app.use(routeLogger.middlewareFunc)
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.use(cors({
    origin: function (origin, callback) {
        // allow requests with no origin
        // (like mobile apps or curl requests)
        if (!origin) return callback(null, true)
        if (allowedOrigins.indexOf(origin) === -1) {
            var msg = 'The CORS policy for this site does not ' +
                'allow access from the specified Origin.'
            return callback(new Error(msg), false)
        }
        return callback(null, true)
    }
}))

// routes
app.use('/api', heartbeatsRouter)

// run server
app.listen(3000, () => {
    console.log('REST API listing on port 3000')
})
