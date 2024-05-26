import 'package:apple_shop/utils/api_exception.dart';
import 'package:apple_shop/utils/auth_manager.dart';
import 'package:apple_shop/utils/dio_provider.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationRemote {
  Future<void> register(
    String userName,
    String password,
    String passwordConfirm,
  );
  Future<String> login(
    String userName,
    String password,
  );
}

class AuthenticationRemote extends IAuthenticationRemote {
  final Dio _dio = DioProvider.createDioWithOutHeader();
  @override
  Future<void> register(
      String userName, String password, String passwordConfirm) async {
    try {
      var response = await _dio.post(
        'collections/users/records',
        data: {
          'username': userName,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
      if (response.statusCode == 200) {
        login(userName, password);
      }
    } on DioException catch (e) {
      throw CustomApiException(
          e.response?.statusCode, e.response?.data['message'],
          response: e.response);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }
  }

  @override
  Future<String> login(String userName, String password) async {
    try {
      Response response = await _dio.post(
        'collections/users/auth-with-password',
        data: {
          'identity': userName,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        AuthManager.saveUserId(response.data['record']['id']);
        AuthManager.saveToken(response.data['token']);
        return response.data['token'];
      }
    } on DioException catch (e) {
      throw CustomApiException(
          e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }

    return '';
  }
}
