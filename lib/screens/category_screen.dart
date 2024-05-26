import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/category/category_state.dart';
import 'package:apple_shop/bloc/product_category/product_category_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/screens/product_list_screen.dart';
import 'package:apple_shop/utils/custom_loading.dart';
import 'package:apple_shop/widgets/cached_network_iamge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
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
                        const Expanded(
                          child: Text(
                            'دسته بندی',
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
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (BuildContext context, CategoryState state) {
                if (state is CategoryInitState) {
                  return const SliverToBoxAdapter(child: Text(''));
                }
                if (state is CategoryLoadingState) {
                  return const SliverToBoxAdapter(
                    child: CustomLoadingWidget(),
                  );
                }
                //
                else if (state is CategorySuccessState) {
                  return state.response.fold(
                    (l) => Center(child: Text(l)),
                    (listCategorydata) => ListCategory(
                      listCategory: listCategorydata,
                    ),
                  );
                }
                //
                else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('error'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListCategory extends StatelessWidget {
  const ListCategory({
    super.key,
    required this.listCategory,
  });

  final List<CategoryModel> listCategory;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: listCategory.length,
          (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider<ProductCategoryBloc>(
                        create: (context) => ProductCategoryBloc(),
                        child: ProductListScreen(
                          categoryModel: listCategory[index],
                        ),
                      );
                    },
                  ),
                );
              },
              child: CachedImage(url: listCategory[index].thumbnail ?? ''),
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
