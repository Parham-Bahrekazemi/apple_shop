import 'package:apple_shop/data/model/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductCategoryState {}

class ProductCategoryInitState extends ProductCategoryState {}

class ProductCategoryLoadingState extends ProductCategoryState {}

class ProductCategorySuccessState extends ProductCategoryState {
  Either<String, List<ProductModel>> productList;

  ProductCategorySuccessState(this.productList);
}
