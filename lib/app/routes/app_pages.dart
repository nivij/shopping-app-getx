import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/auth_screen.dart';
import '../screens/base.dart';
import '../screens/binding/root_bindings.dart';
import '../screens/product_screen.dart';
part 'routing.dart';
class AppPages{
  AppPages._();
  static const INITIAL=Routes.LOGIN;

  static final routes=[
    GetPage(
        name: _Paths.BASE,
        page: () => base(),
        binding: RootBindings()
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => AuthView(),
        binding: RootBindings()
    ),
    GetPage(
        name: '/product_screen',
        page: () => ProductScreen(),
        binding: RootBindings()
    )
  ];
}

