import 'package:apple_shop/data/model/card_item.dart';
import 'package:dartz/dartz.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchState extends BasketState {
  Either<String, List<BasketItemModel>> listBasket;

  Either<String, int> finalPrice;

  BasketDataFetchState(
    this.listBasket,
    this.finalPrice,
  );
}
