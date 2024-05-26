import 'dart:ui';
import 'package:apple_shop/bloc/paymnet/payment_bloc.dart';
import 'package:apple_shop/di.dart';
import 'package:flutter/material.dart';
import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/category/category_event.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/screens/card_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apple_shop/screens/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _MyAppState();
}

class _MyAppState extends State<DashboardScreen> {
  int index = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: index,
          children: getScreen(),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (int value) {
                setState(() {
                  index = value;
                });
              },
              selectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 10,
                color: CustomColor.blue,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 10,
                color: CustomColor.gray,
              ),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: <BottomNavigationBarItem>[
                //1
                BottomNavigationBarItem(
                  activeIcon: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 13),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_profile_active.png'),
                  ),
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 13),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_profile.png'),
                  ),
                  label: 'حساب کاربری',
                ),
                //2
                BottomNavigationBarItem(
                  activeIcon: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 13),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_basket_active.png'),
                  ),
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 13),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_basket.png'),
                  ),
                  label: 'سبد خرید',
                ),
                //3
                BottomNavigationBarItem(
                  activeIcon: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 13),
                        ),
                      ],
                    ),
                    child:
                        Image.asset('assets/images/icon_category_active.png'),
                  ),
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 13),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_category.png'),
                  ),
                  label: 'دسته بندی',
                ),

                //4
                BottomNavigationBarItem(
                  activeIcon: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 13),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_home_active.png'),
                  ),
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 13),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_home.png'),
                  ),
                  label: 'خانه',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> getScreen() {
  return <Widget>[
    const ProfileScreen(),
    BlocProvider<PaymentBloc>.value(
      value: locator.get<PaymentBloc>(),
      child: const CardScreen(),
    ),
    BlocProvider<CategoryBloc>(
      create: (BuildContext context) =>
          locator.get<CategoryBloc>()..add(CategoryGetInfoEvent()),
      child: const CategoryScreen(),
    ),
    Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc()..add(HomeGetInfoEvent()),
        child: const HomeScreen(),
      ),
    ),
  ];
}
