import 'package:apple_shop/bloc/product_category/product_category_event.dart';
import 'package:apple_shop/bloc/product_category/product_category_state.dart';
import 'package:apple_shop/data/model/product_model.dart';
import 'package:apple_shop/data/repository/product_category_list_repository.dart';
import 'package:apple_shop/di.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final IProductCategoryRepository _repository = locator.get();
  ProductCategoryBloc() : super(ProductCategoryInitState()) {
    on<ProductCategoryGetInfoEvent>((event, emit) async {
      emit(ProductCategoryLoadingState());

      Either<String, List<ProductModel>> listProduct =
          await _repository.getProductByCategory(event.categoryId);

      emit(ProductCategorySuccessState(listProduct));
    });
  }
}
