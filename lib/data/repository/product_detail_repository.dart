import 'package:apple_shop/data/data_source/product_detail_data_source.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/data/model/gallery_model.dart';
import 'package:apple_shop/data/model/product_properties_model.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IDetailProductRepository {
  Future<Either<String, List<ProductImageModel>>> getGallery(String productId);
  Future<Either<String, List<VariantTypeModel>>> getVariantType();
  Future<Either<String, List<PorductVariantModel>>> getProductVariant(
      String productId);
  Future<Either<String, CategoryModel>> getCategories(String categoryId);
  Future<Either<String, List<ProdutPropertiesModel>>> getProperties(
      String productId);
}

class DetailProductRepository extends IDetailProductRepository {
  final IDetailProductDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<ProductImageModel>>> getGallery(
    String productId,
  ) async {
    try {
      List<ProductImageModel> listGallery =
          await _dataSource.getGallery(productId);
      return Right(listGallery);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<VariantTypeModel>>> getVariantType() async {
    try {
      List<VariantTypeModel> listVariantType =
          await _dataSource.getVariantType();
      return Right(listVariantType);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PorductVariantModel>>> getProductVariant(
      String productId) async {
    try {
      List<PorductVariantModel> listprodcutVariant =
          await _dataSource.getProductVariant(productId);
      return Right(listprodcutVariant);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CategoryModel>> getCategories(String categoryId) async {
    try {
      CategoryModel category = await _dataSource.getCategories(categoryId);
      return Right(category);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProdutPropertiesModel>>> getProperties(
      String productId) async {
    try {
      List<ProdutPropertiesModel> category =
          await _dataSource.getProperties(productId);
      return Right(category);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
