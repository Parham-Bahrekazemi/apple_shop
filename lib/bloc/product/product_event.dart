import 'package:apple_shop/data/model/product_model.dart';

abstract class ProductEvent {}

class ProductInitializeEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializeEvent(this.productId, this.categoryId);
}

class ProductAddToBasketEvent extends ProductEvent {
  ProductModel product;

  ProductAddToBasketEvent(this.product);
}
