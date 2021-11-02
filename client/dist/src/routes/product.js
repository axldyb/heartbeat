"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.productRouter = void 0;
const express_1 = require("express");
const grpcRoutes = require("./grpc");
// new router
const productRouter = express_1.Router();
exports.productRouter = productRouter;
// routes
productRouter.get('/products', grpcRoutes.listProducts);
productRouter.get('/products/:id', grpcRoutes.readProduct);
productRouter.post('/products', grpcRoutes.createProduct);
productRouter.put('/products/:id', grpcRoutes.updateProduct);
productRouter.delete('/products/:id', grpcRoutes.deleteProduct);
//# sourceMappingURL=product.js.map