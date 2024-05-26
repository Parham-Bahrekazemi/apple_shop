import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/banner_model.dart';
import 'package:apple_shop/widgets/cached_network_iamge.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key, required this.bannerList});

  final List<BannerModel> bannerList;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(
      viewportFraction: 0.9,
      initialPage: 1,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: pageController,
              itemCount: bannerList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedImage(
                      url: bannerList[index].thumbnail ?? '',
                      radius: 15,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            child: SmoothPageIndicator(
              controller: pageController,
              count: bannerList.length,
              effect: const ExpandingDotsEffect(
                expansionFactor: 5,
                dotHeight: 5,
                dotWidth: 5,
                dotColor: Colors.white,
                activeDotColor: CustomColor.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
