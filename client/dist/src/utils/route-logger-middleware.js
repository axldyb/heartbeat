"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RouteLoggerMiddleware = void 0;
class RouteLoggerMiddleware {
    constructor() {
        this.middlewareFunc = (req, res, next) => {
            return this.routeLogger(req, res, next);
        };
    }
    routeLogger(req, _, next) {
        const userAgent = req.get('User-Agent') || 'unknown';
        console.log(`${req.method} ${req.path} from user agent ${userAgent}`);
        return next();
    }
}
exports.RouteLoggerMiddleware = RouteLoggerMiddleware;
//# sourceMappingURL=route-logger-middleware.js.map