import 'package:apple_shop/bloc/basket/basket_bloc.dart';

import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/product_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/utils/extentions/int_extention.dart';
import 'package:apple_shop/widgets/cached_network_iamge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider<BasketBloc>.value(
              value: locator.get<BasketBloc>(),
              child: ProductDetailScreen(
                productModel: productModel,
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 10),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  width: 98,
                  height: 98,
                  child: CachedImage(
                    url: productModel.thumbnail ?? '',
                    boxFit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset('assets/images/active_fav_product.png'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Container(
                    // width: 25,
                    // height: 15,
                    decoration: BoxDecoration(
                      color: CustomColor.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 6,
                        ),
                        child: Text(
                          '${productModel.prsent!.round().toString()}%',
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(
                    productModel.name.toString(),
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  height: 53,
                  decoration: const BoxDecoration(
                    color: CustomColor.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.blue,
                        blurRadius: 25,
                        spreadRadius: -12,
                        offset: Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                              'assets/images/icon_right_arrow_cricle.png'),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              productModel.finalPrice.separateFarsiPrice,
                              style: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: CustomColor.backgroundScreenColor,
                              ),
                            ),
                            Text(
                              productModel.price.separateFarsiPrice,
                              style: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'تومان',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
