abstract class BasketEvent {}

class BasketFetchFromHiveEvent extends BasketEvent {}

// class BasketPaymentInitEvent extends BasketEvent {
//   int finalPrice;
//   BasketPaymentInitEvent(this.finalPrice);
// }

// class BasketPaymentRequestEvent extends BasketEvent {}

class BasketRemoveProductEvent extends BasketEvent {
  int index;
  BasketRemoveProductEvent(this.index);
}
