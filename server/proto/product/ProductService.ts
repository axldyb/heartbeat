// Original file: product.proto

import type * as grpc from '@grpc/grpc-js'
import type { MethodDefinition } from '@grpc/proto-loader'
import type { Empty as _product_Empty, Empty__Output as _product_Empty__Output } from '../product/Empty';
import type { Product as _product_Product, Product__Output as _product_Product__Output } from '../product/Product';
import type { ProductId as _product_ProductId, ProductId__Output as _product_ProductId__Output } from '../product/ProductId';
import type { ProductList as _product_ProductList, ProductList__Output as _product_ProductList__Output } from '../product/ProductList';
import type { newProduct as _product_newProduct, newProduct__Output as _product_newProduct__Output } from '../product/newProduct';
import type { result as _product_result, result__Output as _product_result__Output } from '../product/result';

export interface ProductServiceClient extends grpc.Client {
  createProduct(argument: _product_newProduct, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  createProduct(argument: _product_newProduct, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  createProduct(argument: _product_newProduct, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  createProduct(argument: _product_newProduct, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  createProduct(argument: _product_newProduct, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  createProduct(argument: _product_newProduct, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  createProduct(argument: _product_newProduct, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  createProduct(argument: _product_newProduct, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  
  deleteProduct(argument: _product_ProductId, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  deleteProduct(argument: _product_ProductId, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  deleteProduct(argument: _product_ProductId, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  deleteProduct(argument: _product_ProductId, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  deleteProduct(argument: _product_ProductId, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  deleteProduct(argument: _product_ProductId, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  deleteProduct(argument: _product_ProductId, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  deleteProduct(argument: _product_ProductId, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  
  listProducts(argument: _product_Empty, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_ProductList__Output) => void): grpc.ClientUnaryCall;
  listProducts(argument: _product_Empty, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_ProductList__Output) => void): grpc.ClientUnaryCall;
  listProducts(argument: _product_Empty, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_ProductList__Output) => void): grpc.ClientUnaryCall;
  listProducts(argument: _product_Empty, callback: (error?: grpc.ServiceError, result?: _product_ProductList__Output) => void): grpc.ClientUnaryCall;
  listProducts(argument: _product_Empty, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_ProductList__Output) => void): grpc.ClientUnaryCall;
  listProducts(argument: _product_Empty, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_ProductList__Output) => void): grpc.ClientUnaryCall;
  listProducts(argument: _product_Empty, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_ProductList__Output) => void): grpc.ClientUnaryCall;
  listProducts(argument: _product_Empty, callback: (error?: grpc.ServiceError, result?: _product_ProductList__Output) => void): grpc.ClientUnaryCall;
  
  readProduct(argument: _product_ProductId, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_Product__Output) => void): grpc.ClientUnaryCall;
  readProduct(argument: _product_ProductId, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_Product__Output) => void): grpc.ClientUnaryCall;
  readProduct(argument: _product_ProductId, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_Product__Output) => void): grpc.ClientUnaryCall;
  readProduct(argument: _product_ProductId, callback: (error?: grpc.ServiceError, result?: _product_Product__Output) => void): grpc.ClientUnaryCall;
  readProduct(argument: _product_ProductId, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_Product__Output) => void): grpc.ClientUnaryCall;
  readProduct(argument: _product_ProductId, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_Product__Output) => void): grpc.ClientUnaryCall;
  readProduct(argument: _product_ProductId, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_Product__Output) => void): grpc.ClientUnaryCall;
  readProduct(argument: _product_ProductId, callback: (error?: grpc.ServiceError, result?: _product_Product__Output) => void): grpc.ClientUnaryCall;
  
  updateProduct(argument: _product_Product, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  updateProduct(argument: _product_Product, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  updateProduct(argument: _product_Product, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  updateProduct(argument: _product_Product, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  updateProduct(argument: _product_Product, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  updateProduct(argument: _product_Product, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  updateProduct(argument: _product_Product, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  updateProduct(argument: _product_Product, callback: (error?: grpc.ServiceError, result?: _product_result__Output) => void): grpc.ClientUnaryCall;
  
}

export interface ProductServiceHandlers extends grpc.UntypedServiceImplementation {
  createProduct: grpc.handleUnaryCall<_product_newProduct__Output, _product_result>;
  
  deleteProduct: grpc.handleUnaryCall<_product_ProductId__Output, _product_result>;
  
  listProducts: grpc.handleUnaryCall<_product_Empty__Output, _product_ProductList>;
  
  readProduct: grpc.handleUnaryCall<_product_ProductId__Output, _product_Product>;
  
  updateProduct: grpc.handleUnaryCall<_product_Product__Output, _product_result>;
  
}

export interface ProductServiceDefinition extends grpc.ServiceDefinition {
  createProduct: MethodDefinition<_product_newProduct, _product_result, _product_newProduct__Output, _product_result__Output>
  deleteProduct: MethodDefinition<_product_ProductId, _product_result, _product_ProductId__Output, _product_result__Output>
  listProducts: MethodDefinition<_product_Empty, _product_ProductList, _product_Empty__Output, _product_ProductList__Output>
  readProduct: MethodDefinition<_product_ProductId, _product_Product, _product_ProductId__Output, _product_Product__Output>
  updateProduct: MethodDefinition<_product_Product, _product_result, _product_Product__Output, _product_result__Output>
}
