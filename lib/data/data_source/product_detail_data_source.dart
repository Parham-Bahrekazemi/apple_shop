import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/data/model/gallery_model.dart';
import 'package:apple_shop/data/model/product_properties_model.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant_model.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IDetailProductDataSource {
  Future<List<ProductImageModel>> getGallery(String productId);
  Future<List<VariantTypeModel>> getVariantType();
  Future<List<VariantModel>> getVariant(String productId);
  Future<List<PorductVariantModel>> getProductVariant(String productId);
  Future<CategoryModel> getCategories(String categoryId);
  Future<List<ProdutPropertiesModel>> getProperties(String productId);
}

class ProdcutDetailDataSource extends IDetailProductDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImageModel>> getGallery(String productId) async {
    try {
      Map<String, String> params = {
        'filter': 'product_id="$productId"',
      };
      Response response = await _dio.get(
        'collections/gallery/records',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        List<ProductImageModel> listGallery = response.data['items']
            .map<ProductImageModel>(
                (jsonObject) => ProductImageModel.fromJson(jsonObject))
            .toList();

        return listGallery;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }

  @override
  Future<List<VariantTypeModel>> getVariantType() async {
    try {
      Response response = await _dio.get(
        'collections/variants_type/records',
      );

      if (response.statusCode == 200) {
        List<VariantTypeModel> listVariantType = response.data['items']
            .map<VariantTypeModel>(
                (jsonObject) => VariantTypeModel.fromJson(jsonObject))
            .toList();

        return listVariantType;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }

  @override
  Future<List<VariantModel>> getVariant(String productId) async {
    try {
      Map<String, String> params = {
        'filter': 'product_id="$productId"',
      };
      Response response = await _dio.get(
        'collections/variants/records',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        List<VariantModel> listVariant = response.data['items']
            .map<VariantModel>(
                (jsonObject) => VariantModel.fromJson(jsonObject))
            .toList();

        return listVariant;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }

  @override
  Future<List<PorductVariantModel>> getProductVariant(String productId) async {
    var variantTypeList = await getVariantType();
    var variantsList = await getVariant(productId);

    List<PorductVariantModel> productVariantList = [];

    for (var varinatType in variantTypeList) {
      var listSeparate = variantsList
          .where((element) => element.typeId == varinatType.id)
          .toList();

      productVariantList.add(PorductVariantModel(varinatType, listSeparate));
    }

    return productVariantList;
  }

  @override
  Future<CategoryModel> getCategories(String categoryId) async {
    Map<String, String> params = {
      'filter': 'id="$categoryId"',
    };
    try {
      Response response = await _dio.get(
        'collections/category/records',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        CategoryModel category =
            CategoryModel.fromJson(response.data['items'][0]);

        return category;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return CategoryModel(null, null, null, null, null, null);
  }

  @override
  Future<List<ProdutPropertiesModel>> getProperties(String productId) async {
    Map<String, String> params = {
      'filter': 'product_id="$productId"',
    };
    try {
      Response response = await _dio.get(
        'collections/properties/records',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        List<ProdutPropertiesModel> listProperties = response.data['items']
            .map<ProdutPropertiesModel>(
                (jsonObject) => ProdutPropertiesModel.fromJson(jsonObject))
            .toList();

        return listProperties;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }
}
