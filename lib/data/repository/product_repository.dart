import 'package:apple_shop/data/data_source/product_data_source.dart';
import 'package:apple_shop/data/model/product_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductRepository {
  Future<Either<String, List<ProductModel>>> getProducts();
  Future<Either<String, List<ProductModel>>> getProductsHotest();
  Future<Either<String, List<ProductModel>>> getProductsBestSeller();
}

class ProductRepository extends IProductRepository {
  final IProductDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      List<ProductModel> listProducts = await _dataSource.getProducts();
      return Right(listProducts);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProductsBestSeller() async {
    try {
      List<ProductModel> listProducts =
          await _dataSource.getProductsBestSeller();
      return Right(listProducts);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProductsHotest() async {
    try {
      List<ProductModel> listProducts = await _dataSource.getProductsHotest();
      return Right(listProducts);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
