import 'package:apple_shop/data/data_source/category_data_source.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<CategoryModel>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _dataSource;

  CategoryRepository(this._dataSource);
  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      List<CategoryModel> listCategory = await _dataSource.getCategories();
      return Right(listCategory);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست کتگوری گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
