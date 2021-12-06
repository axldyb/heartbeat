import { NextFunction, Request, Response } from 'express'

export interface Middleware {
    middlewareFunc: (req: Request, res: Response, next: NextFunction) => Promise<Response>
}

export class RouteLoggerMiddleware implements Middleware {
    middlewareFunc: (req: Request, res: Response, next: NextFunction) => Promise<Response>

    constructor() {
        this.middlewareFunc = (req: Request, res: Response, next: NextFunction): Promise<Response> => {
            return this.routeLogger(req, res, next)
        }
    }

    private routeLogger(req: Request, _: Response, next): Promise<Response> {
        const userAgent = req.get('User-Agent') || 'unknown'
        console.log(`${req.method} ${req.path} from user agent ${userAgent}`)
        return next()
    }
}