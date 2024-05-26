import 'package:apple_shop/bloc/category/category_event.dart';
import 'package:apple_shop/bloc/category/category_state.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _repository;
  CategoryBloc(this._repository) : super(CategoryInitState()) {
    on<CategoryGetInfoEvent>((event, emit) async {
      emit(CategoryLoadingState());

      Either<String, List<CategoryModel>> response =
          await _repository.getCategories();

      emit(CategorySuccessState(response));
    });
  }
}
