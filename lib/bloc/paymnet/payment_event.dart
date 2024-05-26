import 'package:flutter/widgets.dart';

abstract class PaymentEvent {}

class PaymentInitEvent extends PaymentEvent {
  int finalPrice;
  BuildContext context;
  PaymentInitEvent(this.finalPrice, this.context);
}

class PaymentRequestEvent extends PaymentEvent {}

class PaymentFinalStateEvent extends PaymentEvent {}
