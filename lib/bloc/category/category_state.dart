import 'package:apple_shop/data/model/category_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {
  Either<String, List<CategoryModel>> response;

  CategorySuccessState(this.response);
}
