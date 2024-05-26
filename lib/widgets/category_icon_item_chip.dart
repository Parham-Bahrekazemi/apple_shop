import 'package:apple_shop/bloc/product_category/product_category_bloc.dart';
import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/screens/product_list_screen.dart';
import 'package:apple_shop/utils/extentions/string_extention.dart';
import 'package:apple_shop/widgets/cached_network_iamge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip({
    super.key,
    required this.listCategory,
    required this.index,
  });
  final List<CategoryModel> listCategory;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
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
              child: Container(
                width: 56,
                height: 56,
                decoration: ShapeDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  color: Color(listCategory[index].color.convertToHex),
                  shadows: [
                    BoxShadow(
                      color: Color(listCategory[index].color.convertToHex),
                      blurRadius: 30,
                      spreadRadius: -12,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CachedImage(
                      url: listCategory[index].icon ?? '',
                      boxFit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          listCategory[index].title ?? '',
          style: const TextStyle(
            fontFamily: 'SB',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
