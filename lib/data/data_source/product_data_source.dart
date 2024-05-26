import 'package:apple_shop/data/model/product_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getProductsHotest();
  Future<List<ProductModel>> getProductsBestSeller();
}

class ProductRemoteDataSource extends IProductDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      Response response = await _dio.get(
        'collections/products/records',
      );

      if (response.statusCode == 200) {
        List<ProductModel> listProducts = response.data['items']
            .map<ProductModel>(
                (jsonObject) => ProductModel.fromJson(jsonObject))
            .toList();

        return listProducts;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }

  @override
  Future<List<ProductModel>> getProductsBestSeller() async {
    try {
      Map<String, String> params = {
        'filter': 'popularity="Best Seller"',
      };
      Response response = await _dio.get(
        'collections/products/records',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        List<ProductModel> listProducts = response.data['items']
            .map<ProductModel>(
                (jsonObject) => ProductModel.fromJson(jsonObject))
            .toList();

        return listProducts;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }

  @override
  Future<List<ProductModel>> getProductsHotest() async {
    try {
      Map<String, String> params = {
        'filter': 'popularity="Hotest"',
      };
      Response response = await _dio.get(
        'collections/products/records',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        List<ProductModel> listProducts = response.data['items']
            .map<ProductModel>(
                (jsonObject) => ProductModel.fromJson(jsonObject))
            .toList();

        return listProducts;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }
}
