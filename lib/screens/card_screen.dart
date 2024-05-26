import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/bloc/paymnet/payment_bloc.dart';
import 'package:apple_shop/bloc/paymnet/payment_event.dart';
import 'package:apple_shop/bloc/paymnet/payment_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/custom_loading.dart';
import 'package:apple_shop/utils/extentions/int_extention.dart';
import 'package:apple_shop/utils/extentions/string_extention.dart';
import 'package:apple_shop/widgets/cached_network_iamge.dart';
import 'package:apple_shop/widgets/dialog_error_box.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BasketBloc>(
      create: (context) =>
          locator.get<BasketBloc>()..add(BasketFetchFromHiveEvent()),
      child: const ViewCardScreen(),
    );
  }
}

class ViewCardScreen extends StatefulWidget {
  const ViewCardScreen({
    super.key,
  });

  @override
  State<ViewCardScreen> createState() => _ViewCardScreenState();
}

class _ViewCardScreenState extends State<ViewCardScreen> {
  int finalPrice2 = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: BlocConsumer<BasketBloc, BasketState>(
          listener: (context, state) {
            if (state is BasketDataFetchState) {
              state.finalPrice
                  .fold((l) => null, (finalprice) => finalPrice2 = finalprice);
            }
          },
          builder: (BuildContext context, BasketState state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 22, left: 44, right: 44, top: 20),
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                    'assets/images/icon_apple_blue.png'),
                                const Expanded(
                                  child: Text(
                                    'سبد خرید',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SM',
                                      color: CustomColor.gray,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state is BasketDataFetchState) ...{
                      state.listBasket.fold(
                        (l) => const SliverToBoxAdapter(
                          child: Center(
                            child: Text('محصولی وجود ندارد'),
                          ),
                        ),
                        (listBasket) {
                          if (listBasket.isEmpty) {
                            return SliverToBoxAdapter(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: const Center(
                                  child: Text(
                                    'محصولی وجود ندارد',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: index == (listBasket.length - 1)
                                            ? 100
                                            : 0),
                                    child: CardItem(
                                        basketItemModel: listBasket[index],
                                        index: index),
                                  );
                                },
                                childCount: listBasket.length,
                              ),
                            );
                          }
                        },
                      ),
                    },
                  ],
                ),
                BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (BuildContext context, PaymentState state) {
                    if (state is PaymentInitState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 44, vertical: 20),
                        child: SizedBox(
                          height: 53,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (finalPrice2 != 0) {
                                context.read<PaymentBloc>().add(
                                    PaymentInitEvent(finalPrice2, context));

                                context
                                    .read<PaymentBloc>()
                                    .add(PaymentRequestEvent());
                              }
                            },
                            child: Text(
                              finalPrice2 != 0
                                  ? '${finalPrice2.separateFarsiPrice} : پرداخت مبلغ'
                                  : 'محصولی وجود ندارد',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'SB',
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is PaymentLoadingState) {
                      return const CustomLoadingWidget(
                        height: 0.1,
                      );
                    }

                    if (state is PaymentSuccessState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 44, vertical: 20),
                        child: SizedBox(
                          height: 53,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (finalPrice2 != 0) {
                                context.read<PaymentBloc>().add(
                                    PaymentInitEvent(finalPrice2, context));

                                context
                                    .read<PaymentBloc>()
                                    .add(PaymentRequestEvent());
                              }
                            },
                            child: Text(
                              finalPrice2 != 0
                                  ? '${finalPrice2.separateFarsiPrice} : پرداخت مبلغ'
                                  : 'محصولی وجود ندارد',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'SB',
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Text('test');
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.basketItemModel,
    required this.index,
  });

  final BasketItemModel basketItemModel;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 44, vertical: 10),
      height: 249,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 17,
                      right: 18,
                      bottom: 10,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            basketItemModel.name ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'SB',
                            ),
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'گارانتی 18 ماه مدیا پردازش',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'SM',
                              color: CustomColor.gray,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 35,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: CustomColor.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '%${basketItemModel.prsent?.round()}',
                                    style: const TextStyle(
                                      fontFamily: 'SM',
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${basketItemModel.finalPrice.separateFarsiPrice} تومان',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SM',
                                  color: CustomColor.gray,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            textDirection: TextDirection.rtl,
                            direction: Axis.horizontal,
                            children: [
                              // const OptionChip(
                              //   title: '128 گیگابایت',
                              // ),
                              const OptionChip(
                                title: 'رنگ محصول',
                                color: '1DB68B',
                              ),

                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<BasketBloc>()
                                      .add(BasketRemoveProductEvent(index));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: CustomColor.red,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 10),
                                        const Text(
                                          'حذف',
                                          style: TextStyle(
                                            fontFamily: 'SM',
                                            fontSize: 10,
                                            color: CustomColor.red,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        const SizedBox(width: 4),
                                        Image.asset(
                                          'assets/images/icon_trash.png',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // OptionChip(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, right: 10),
                  child: SizedBox(
                    height: 104,
                    width: 80,
                    child: CachedImage(
                      url: basketItemModel.thumbnail ?? '',
                      boxFit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: DottedLine(
              lineThickness: 3,
              dashLength: 8,
              dashGapLength: 3,
              dashGapColor: Colors.transparent,
              dashColor: CustomColor.backgroundScreenColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              '${basketItemModel.finalPrice.separateFarsiPrice} تومان',
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'SM',
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}

class OptionChip extends StatelessWidget {
  const OptionChip({
    super.key,
    this.color,
    required this.title,
  });

  final String? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CustomColor.gray,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (color != null) ...{
              Container(
                margin: const EdgeInsets.only(
                  right: 8,
                ),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(color?.convertToHex),
                  shape: BoxShape.circle,
                ),
              )
            },
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'SM',
                fontSize: 10,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
