import 'package:apple_shop/bloc/authentication/authentication_bloc.dart';
import 'package:apple_shop/bloc/authentication/authentication_state.dart';
import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/screens/dashboard_screen.dart';
import 'package:apple_shop/screens/login_screen.dart';
import 'package:apple_shop/utils/auth_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/adapters.dart';

GlobalKey<NavigatorState> globalNavigationKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemModelAdapter());
  await Hive.openBox<BasketItemModel>('CardBox');
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavigationKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AuthManager.isLogin() ? const DashboardScreen() : LoginScreen(),
      ),
    );
  }
}

bool? payment;
