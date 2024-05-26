import 'package:apple_shop/data/model/banner_model.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/data/model/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSucessState extends HomeState {
  Either<String, List<BannerModel>> bannerLsit;
  Either<String, List<CategoryModel>> categoryLsit;
  Either<String, List<ProductModel>> productList;
  Either<String, List<ProductModel>> productHotestList;
  Either<String, List<ProductModel>> productBestSellerList;

  HomeSucessState(
    this.bannerLsit,
    this.categoryLsit,
    this.productList,
    this.productHotestList,
    this.productBestSellerList,
  );
}
