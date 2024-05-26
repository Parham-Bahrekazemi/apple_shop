import 'package:apple_shop/data/model/product_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductCategoryListDataSource {
  Future<List<ProductModel>> getProductByCategory(String categoryId);
}

class ProductCategoryListRemote extends IProductCategoryListDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductModel>> getProductByCategory(String categoryId) async {
    try {
      Response response;
      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get(
          'collections/products/records',
        );
      } else {
        Map<String, String> params = <String, String>{
          'filter': 'category="$categoryId"'
        };

        response = await _dio.get(
          'collections/products/records',
          queryParameters: params,
        );
      }

      if (response.statusCode == 200) {
        List<ProductModel> listProduct = response.data['items']
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();

        return listProduct;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }
}
