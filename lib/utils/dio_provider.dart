import 'package:apple_shop/utils/auth_manager.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDio() {
    print('auth : ${AuthManager.readAuth()}');
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager.readAuth()}',
        },
      ),
    );

    return dio;
  }

  static Dio createDioWithOutHeader() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
      ),
    );

    return dio;
  }
}
