import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/data/model/gallery_model.dart';
import 'package:apple_shop/data/model/product_properties_model.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  Either<String, List<ProductImageModel>> listGallery;
  Either<String, List<PorductVariantModel>> productVariants;
  Either<String, CategoryModel> category;
  Either<String, List<ProdutPropertiesModel>> properties;

  ProductSuccessState(
    this.listGallery,
    this.productVariants,
    this.category,
    this.properties,
  );
}
