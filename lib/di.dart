import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/paymnet/payment_bloc.dart';
import 'package:apple_shop/data/data_source/authentication_data_source.dart';
import 'package:apple_shop/data/data_source/basket_data_source.dart';
import 'package:apple_shop/data/data_source/comment_data_source.dart';
import 'package:apple_shop/data/data_source/home_data_source.dart';
import 'package:apple_shop/data/data_source/category_data_source.dart';
import 'package:apple_shop/data/data_source/product_category_list_data_source.dart';
import 'package:apple_shop/data/data_source/product_data_source.dart';
import 'package:apple_shop/data/data_source/product_detail_data_source.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/basket_item_repository.dart';
import 'package:apple_shop/data/repository/comment_repository.dart';
import 'package:apple_shop/data/repository/home_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_category_list_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/utils/dio_provider.dart';
import 'package:apple_shop/utils/payment_handler.dart';
import 'package:apple_shop/utils/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarinpal/zarinpal.dart';

GetIt locator = GetIt.instance;
Future<void> getItInit() async {
//components

  await _initComponents();

  //dataSource
  _initDataSource();

  //repository
  _initRepository();

  //bloc
  _blocInit();
}

Future<void> _initComponents() async {
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  locator.registerSingleton<Dio>(DioProvider.createDio());

  //util

  locator.registerSingleton<UrlHandler>(UrlLauncher());

  locator.registerSingleton<PaymentRequest>(PaymentRequest());

  locator.registerSingleton<PaymentHandler>(
      ZarinPalPaymentHandler(locator.get(), locator.get()));
}

void _initDataSource() {
  locator.registerFactory<IAuthenticationRemote>(() => AuthenticationRemote());
  locator.registerFactory<ICategoryDataSource>(
      () => CategoryRemoteDataSource(locator.get()));
  locator.registerFactory<IBannerDataSource>(() => BannerRemoteDataSource());

  locator.registerFactory<IProductDataSource>(() => ProductRemoteDataSource());
  locator.registerFactory<IDetailProductDataSource>(
      () => ProdcutDetailDataSource());
  locator.registerFactory<IProductCategoryListDataSource>(
      () => ProductCategoryListRemote());
  locator.registerFactory<IBasketDataSource>(() => BasketLocaleDataSource());
  locator.registerFactory<ICommentDataSource>(() => CommentRemoteDataSource());
}

void _initRepository() {
  locator.registerFactory<IAuthenticationRepository>(
    () => AuthenticationRepository(),
  );

  locator.registerFactory<ICategoryRepository>(
      () => CategoryRepository(locator.get()));

  locator.registerFactory<IBannerRepository>(() => BannerRepository());

  locator.registerFactory<IProductRepository>(() => ProductRepository());

  locator.registerFactory<IDetailProductRepository>(
      () => DetailProductRepository());

  locator.registerFactory<IProductCategoryRepository>(
      () => ProductCategoryRepository());

  locator.registerFactory<IBasketRepository>(() => BasketRepository());
  locator.registerFactory<ICommentRepository>(() => CommentRepository());
}

void _blocInit() {
  locator.registerSingleton<BasketBloc>(
    BasketBloc(
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerSingleton<CategoryBloc>(
    CategoryBloc(
      locator.get(),
    ),
  );

  locator.registerSingleton<PaymentBloc>(
    PaymentBloc(
      locator.get(),
    ),
  );
}
