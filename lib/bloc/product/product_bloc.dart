import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/data/model/gallery_model.dart';
import 'package:apple_shop/data/model/product_properties_model.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/repository/basket_item_repository.dart';

import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/di.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc extends Bloc<ProductEvent, ProductState> {
  final IDetailProductRepository _repository = locator.get();

  final IBasketRepository _repositoryBasket = locator.get();
  ProductDetailBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>((event, emit) async {
      emit(ProductLoadingState());

      Either<String, List<ProductImageModel>> listGallery =
          await _repository.getGallery(event.productId);

      Either<String, List<PorductVariantModel>> listProductVariant =
          await _repository.getProductVariant(event.productId);

      Either<String, CategoryModel> category =
          await _repository.getCategories(event.categoryId);
      Either<String, List<ProdutPropertiesModel>> properties =
          await _repository.getProperties(event.productId);

      emit(ProductSuccessState(
          listGallery, listProductVariant, category, properties));
    });

    on<ProductAddToBasketEvent>((event, emit) async {
      BasketItemModel basketItem = BasketItemModel(
        event.product.id,
        event.product.collectionId,
        event.product.thumbnail,
        event.product.discountPrice,
        event.product.price,
        event.product.name,
        event.product.category,
      );

      _repositoryBasket.addToBasket(basketItem);
    });
  }
}
