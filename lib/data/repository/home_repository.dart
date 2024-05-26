import 'package:apple_shop/data/data_source/home_data_source.dart';
import 'package:apple_shop/data/model/banner_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerModel>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<BannerModel>>> getBanners() async {
    try {
      List<BannerModel> listCategory = await _dataSource.getBanners();
      return Right(listCategory);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
