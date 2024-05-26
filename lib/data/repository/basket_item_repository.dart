import 'package:apple_shop/data/data_source/basket_data_source.dart';
import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/di.dart';
import 'package:dartz/dartz.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addToBasket(BasketItemModel basketItemModel);
  Future<Either<String, List<BasketItemModel>>> getAllBasketItem();
  Future<Either<String, int>> getFinalPriceBasket();

  Future<Either<String, String>> deleteProductFromBasket(int index);
}

class BasketRepository extends IBasketRepository {
  final IBasketDataSource _dataSource = locator.get();
  @override
  Future<Either<String, String>> addToBasket(
      BasketItemModel basketItemModel) async {
    try {
      _dataSource.addToBasket(basketItemModel);
      return const Right('محصول به سبد خرید اضافه شد');
    } catch (e) {
      return const Left('خطا در افزودن محصول در سبد خرید');
    }
  }

  @override
  Future<Either<String, List<BasketItemModel>>> getAllBasketItem() async {
    try {
      List<BasketItemModel> listBasket = await _dataSource.getAllBasketItem();
      return Right(listBasket);
    } catch (e) {
      return const Left('خطا در گرفتن لیست سبد خرید');
    }
  }

  @override
  Future<Either<String, int>> getFinalPriceBasket() async {
    try {
      int finalPrice = await _dataSource.getFinalPriceBasket();
      return Right(finalPrice);
    } catch (e) {
      return const Left('خطا در گرفتن قیمت نهایی');
    }
  }

  @override
  Future<Either<String, String>> deleteProductFromBasket(int index) async {
    try {
      await _dataSource.deleteProductFromBasket(index);
      return const Right('محصول پاک شد');
    } catch (e) {
      return const Left('خطا در گرفتن قیمت نهایی');
    }
  }
}
