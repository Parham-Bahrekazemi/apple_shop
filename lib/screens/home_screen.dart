import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/utils/custom_loading.dart';

import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:apple_shop/widgets/category_icon_item_chip.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              color: CustomColor.blue,
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeGetInfoEvent());
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  const SearchBox(),
                  if (state is HomeLoadingState) ...[
                    const SliverToBoxAdapter(
                      child: Center(
                        child: CustomLoadingWidget(),
                      ),
                    ),
                  ],
                  if (state is HomeSucessState) ...[
                    state.bannerLsit.fold(
                      (l) => SliverToBoxAdapter(child: Text(l)),
                      (bannerList) => SliverToBoxAdapter(
                        child: BannerSlider(
                          bannerList: bannerList,
                        ),
                      ),
                    ),
                    const GetCategoryListTitle(),
                    state.categoryLsit.fold(
                      (l) => SliverToBoxAdapter(child: Text(l)),
                      (bannerList) => GetCategoryList(
                        listCategory: bannerList,
                      ),
                    ),
                    const GetBesSellerTitle(),
                    state.productBestSellerList.fold(
                      (l) => SliverToBoxAdapter(child: Text(l)),
                      (productBestSellerList) => SliverToBoxAdapter(
                        child: SizedBox(
                          height: 216,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 44),
                            child: ListView.builder(
                              itemCount: productBestSellerList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: ProductItem(
                                    productModel: productBestSellerList[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (state is HomeSucessState) ...[
                    const GetMostViewTitle(),
                    state.productHotestList.fold(
                      (l) => SliverToBoxAdapter(child: Text(l)),
                      (productHotestList) => SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: SizedBox(
                            height: 216,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 44),
                              child: ListView.builder(
                                itemCount: productHotestList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: ProductItem(
                                        productModel: productHotestList[index]),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class GetCategoryList extends StatelessWidget {
  const GetCategoryList({
    super.key,
    required this.listCategory,
  });

  final List<CategoryModel> listCategory;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: listCategory.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CategoryItemChip(
                  listCategory: listCategory,
                  index: index,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class GetMostViewTitle extends StatelessWidget {
  const GetMostViewTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 32),
        child: Row(
          children: <Widget>[
            const Text(
              'پر بازدید ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColor.gray,
              ),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColor.blue,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class GetBesSellerTitle extends StatelessWidget {
  const GetBesSellerTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: <Widget>[
            const Text(
              'پر فروش ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColor.gray,
              ),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColor.blue,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class GetCategoryListTitle extends StatelessWidget {
  const GetCategoryListTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'مشاهده همه',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColor.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 32, left: 44, right: 44, top: 20),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/icon_search.png'),
                const SizedBox(width: 10),
                const Text(
                  'جستجوی محصولات',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SM',
                    color: CustomColor.gray,
                  ),
                ),
                const Spacer(),
                Image.asset('assets/images/icon_apple_blue.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
