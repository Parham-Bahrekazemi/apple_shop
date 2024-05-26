import 'package:apple_shop/data/model/card_item.dart';
import 'package:hive/hive.dart';

abstract class IBasketDataSource {
  Future<void> addToBasket(BasketItemModel basketItemModel);
  Future<List<BasketItemModel>> getAllBasketItem();
  Future<int> getFinalPriceBasket();
  Future<void> deleteProductFromBasket(int index);
}

class BasketLocaleDataSource extends IBasketDataSource {
  Box<BasketItemModel> box = Hive.box<BasketItemModel>('CardBox');
  @override
  Future<void> addToBasket(BasketItemModel basketItemModel) async {
    box.add(basketItemModel);
  }

  @override
  Future<List<BasketItemModel>> getAllBasketItem() async {
    return box.values.toList();
  }

  @override
  Future<int> getFinalPriceBasket() async {
    List<BasketItemModel> basketList = box.values.toList();
    int finalPrice = basketList.fold(
        0, (previousValue, element) => previousValue + element.finalPrice!);

    return finalPrice;
  }

  @override
  Future<void> deleteProductFromBasket(int index) async {
    box.deleteAt(index);
  }
}
