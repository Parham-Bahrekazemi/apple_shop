import 'package:apple_shop/data/data_source/authentication_data_source.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> register(
    String userName,
    String password,
    String passwordConfirm,
  );

  Future<Either<String, String>> login(
    String userName,
    String password,
  );
}

class AuthenticationRepository extends IAuthenticationRepository {
  final IAuthenticationRemote _dataSource = locator.get();

  @override
  Future<Either<String, String>> register(
    String userName,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _dataSource.register(userName, password, passwordConfirm);
      return const Right('با موفقیت ثبت نام شدید');
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'محتوای متنی وجود ندارد');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> login(String userName, String password) async {
    try {
      String token = await _dataSource.login(userName, password);
      if (token.isNotEmpty) {
        return const Right('وارد شدید');
      } else {
        return const Left('خطایی در ورود پیش آمده');
      }
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'محتوای متنی وجود ندارد');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
