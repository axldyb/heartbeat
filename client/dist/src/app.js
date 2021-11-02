"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express = require("express");
const bodyParser = require("body-parser");
const product_1 = require("./routes/product");
const route_logger_middleware_1 = require("./utils/route-logger-middleware");
const routeLogger = new route_logger_middleware_1.RouteLoggerMiddleware();
// express
const app = express();
app.use(routeLogger.middlewareFunc);
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
// routes
app.use('/api', product_1.productRouter);
// run server
app.listen(3000, () => {
    console.log('API client listing on port 3000');
});
//# sourceMappingURL=app.js.map