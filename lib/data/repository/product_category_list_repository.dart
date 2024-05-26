import 'package:apple_shop/data/data_source/product_category_list_data_source.dart';
import 'package:apple_shop/data/model/product_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductCategoryRepository {
  Future<Either<String, List<ProductModel>>> getProductByCategory(
      String categoryId);
}

class ProductCategoryRepository extends IProductCategoryRepository {
  final IProductCategoryListDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<ProductModel>>> getProductByCategory(
      String categoryId) async {
    try {
      List<ProductModel> listCategory =
          await _dataSource.getProductByCategory(categoryId);
      return Right(listCategory);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
