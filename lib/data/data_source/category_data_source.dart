import 'package:apple_shop/data/model/category_model.dart';

import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSource extends ICategoryDataSource {
  final Dio _dio;

  CategoryRemoteDataSource(this._dio);
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      Response response = await _dio.get(
        'collections/category/records',
      );

      if (response.statusCode == 200) {
        List<CategoryModel> listCategory = response.data['items']
            .map<CategoryModel>(
                (jsonObject) => CategoryModel.fromJson(jsonObject))
            .toList();

        return listCategory;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }
}
