abstract class PaymentState {}

class PaymentInitState extends PaymentState {}

class PaymentLoadingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {
  bool? paymentStatus;
  PaymentSuccessState(this.paymentStatus);
}
