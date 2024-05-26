import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/paymnet/payment_bloc.dart';
import 'package:apple_shop/bloc/paymnet/payment_event.dart';
import 'package:apple_shop/bloc/paymnet/payment_state.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/extentions/string_extention.dart';
import 'package:apple_shop/utils/url_handler.dart';
import 'package:apple_shop/widgets/dialog_error_box.dart';
import 'package:apple_shop/widgets/payment_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest(int finalPrice, BuildContext context);
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest(BuildContext context);
}

class ZarinPalPaymentHandler extends PaymentHandler {
  String? _status;
  String? _authority;
  final PaymentRequest _paymentRequest;
  final UrlHandler _urlHandler;

  ZarinPalPaymentHandler(this._urlHandler, this._paymentRequest);

  var a;
  @override
  Future<void> initPaymentRequest(int finalPrice, BuildContext context) async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(finalPrice);
    _paymentRequest.setDescription('this is for test application apple shop');
    _paymentRequest.setMerchantID('cc649ab9-c49d-4b93-8228-38352934292b');
    _paymentRequest.setCallbackURL('parham://shop');

    a = linkStream.listen(
      (deepLink) {
        if (deepLink!.toLowerCase().contains('authority')) {
          _authority = deepLink.extractValueFromQuery('Authority');
          _status = deepLink.extractValueFromQuery('Status');
          verifyPaymentRequest(context);
        }
      },
    );
    a;
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri) {
        if (status == 100) {
          _urlHandler.openUrl(paymentGatewayUri);
        }
      },
    );
  }

  @override
  Future<void> verifyPaymentRequest(BuildContext context) async {
    ZarinPal().verificationPayment(
      _status!,
      _authority!,
      _paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          locator.get<PaymentBloc>().add(PaymentFinalStateEvent());
          paymnetDialog(context, 'با موفقیت پرداخت شد', true);
          a.cancel();
        }
        if (isPaymentSuccess == false) {
          locator.get<PaymentBloc>().add(PaymentFinalStateEvent());

          paymnetDialog(context, 'خطا در پرداخت !', false);
          a.cancel();
        }
      },
    );
  }
}
