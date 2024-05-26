import 'package:apple_shop/bloc/product_category/product_category_bloc.dart';
import 'package:apple_shop/bloc/product_category/product_category_event.dart';
import 'package:apple_shop/bloc/product_category/product_category_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/utils/custom_loading.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductCategoryBloc>(context)
        .add(ProductCategoryGetInfoEvent(widget.categoryModel.id ?? ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
          builder: (BuildContext context, ProductCategoryState state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 32, left: 44, right: 44, top: 20),
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
                            Image.asset('assets/images/icon_apple_blue.png'),
                            Expanded(
                              child: Text(
                                widget.categoryModel.title ?? '',
                                style: const TextStyle(
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
                if (state is ProductCategoryLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: CustomLoadingWidget(),
                  ),
                },
                if (state is ProductCategorySuccessState) ...[
                  state.productList.fold(
                    (l) => SliverToBoxAdapter(
                      child: Center(
                        child: Text(l),
                      ),
                    ),
                    (productList) {
                      if (productList.isEmpty) {
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: const Expanded(
                              child: Center(
                                child: Text(
                                  'محصولی وجود ندارد',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SliverPadding(
                          padding: const EdgeInsets.only(
                            left: 35,
                            right: 35,
                            bottom: 32,
                          ),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              childCount: productList.length,
                              (BuildContext context, int index) {
                                return Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ProductItem(
                                    productModel: productList[index],
                                  ),
                                );
                              },
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 30,
                              childAspectRatio: 2 / 3,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
