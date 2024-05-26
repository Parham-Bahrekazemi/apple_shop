import 'package:apple_shop/bloc/paymnet/payment_event.dart';
import 'package:apple_shop/bloc/paymnet/payment_state.dart';
import 'package:apple_shop/utils/payment_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentHandler paymentHandler;

  static bool? paymentStatus;
  PaymentBloc(this.paymentHandler) : super(PaymentInitState()) {
    on<PaymentInitEvent>((event, emit) async {
      emit(PaymentLoadingState());
      paymentHandler.initPaymentRequest(event.finalPrice, event.context);
    });

    on<PaymentRequestEvent>((event, emit) {
      paymentHandler.sendPaymentRequest();
    });

    on<PaymentFinalStateEvent>(
        (event, emit) => emit(PaymentSuccessState(paymentStatus)));
  }
}
