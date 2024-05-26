import 'package:apple_shop/data/model/banner_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDataSource {
  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDataSource extends IBannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      Response response = await _dio.get(
        'collections/banner/records',
      );

      if (response.statusCode == 200) {
        List<BannerModel> listBanner = response.data['items']
            .map<BannerModel>((jsonObject) => BannerModel.fromJson(jsonObject))
            .toList();

        return listBanner;
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return [];
  }
}
