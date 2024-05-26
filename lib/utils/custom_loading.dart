import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null
          ? MediaQuery.of(context).size.height * 0.6
          : MediaQuery.of(context).size.height * height!,
      child: const Center(
        child: SizedBox(
          height: 60,
          child: LoadingIndicator(
            indicatorType: Indicator.ballRotateChase,

            /// Required, The loading type of the widget
            colors: [CustomColor.blue],

            /// Optional, The color collections
            strokeWidth: 0.1,

            /// Optional, The stroke of the line, only applicable to widget which contains line

            /// Optional, Background of the widget
            // pathBackgroundColor: Colors.black

            /// Optional, the stroke backgroundColor
          ),
        ),
      ),
    );
  }
}
