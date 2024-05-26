import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/data/repository/basket_item_repository.dart';

import 'package:apple_shop/utils/payment_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _repositoryBasket;
  final PaymentHandler paymentHandler;

  static bool? paymentStatus;
  BasketBloc(this.paymentHandler, this._repositoryBasket)
      : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      Either<String, List<BasketItemModel>> basketList =
          await _repositoryBasket.getAllBasketItem();

      Either<String, int> finalPrice =
          await _repositoryBasket.getFinalPriceBasket();

      emit(BasketDataFetchState(basketList, finalPrice));
    });

    // on<BasketPaymentInitEvent>((event, emit) {
    //   paymentHandler.initPaymentRequest(event.finalPrice , ev);
    // });

    // on<BasketPaymentRequestEvent>((event, emit) async {
    //   await paymentHandler.sendPaymentRequest();
    // });

    on<BasketRemoveProductEvent>((event, emit) async {
      Either<String, List<BasketItemModel>> basketList =
          await _repositoryBasket.getAllBasketItem();

      Either<String, int> finalPrice =
          await _repositoryBasket.getFinalPriceBasket();

      await _repositoryBasket.deleteProductFromBasket(event.index);

      emit(BasketDataFetchState(basketList, finalPrice));
    });
  }
}
