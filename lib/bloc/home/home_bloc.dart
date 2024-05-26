import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/data/model/banner_model.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/data/model/product_model.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/home_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/di.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _repositoryBanner = locator.get();
  final ICategoryRepository _repositoryCategory = locator.get();
  final IProductRepository _repositoryProduct = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInfoEvent>((event, emit) async {
      emit(HomeLoadingState());

      Either<String, List<BannerModel>> bannerList =
          await _repositoryBanner.getBanners();

      Either<String, List<CategoryModel>> categoryList =
          await _repositoryCategory.getCategories();

      Either<String, List<ProductModel>> productList =
          await _repositoryProduct.getProducts();

      Either<String, List<ProductModel>> productHotestList =
          await _repositoryProduct.getProductsHotest();
      Either<String, List<ProductModel>> productBestSellerList =
          await _repositoryProduct.getProductsBestSeller();

      emit(
        HomeSucessState(
          bannerList,
          categoryList,
          productList,
          productHotestList,
          productBestSellerList,
        ),
      );
    });
  }
}
