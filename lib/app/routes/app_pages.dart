import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gocart/app/screens/splash_screen.dart';

import '../screens/Cart_screen.dart';
import '../screens/Search_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/base.dart';
import '../screens/binding/root_bindings.dart';
import '../screens/product_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/wishlist_screen.dart';
part 'routing.dart';
class AppPages{
  AppPages._();
  static const INITIAL=Routes.SPLASH;

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
    ), GetPage(
        name: _Paths.SPLASH,
        page: () => Splash(),
        binding: RootBindings()
    ),
    GetPage(
        name: '${_Paths.PRODUCTVIEW}/:index/:color/:photo/:product',
        page: () => ProductScreen(),
        binding: RootBindings()
    ),
    GetPage(
        name: _Paths.CART,
        page: () => CartPage(),
        binding: RootBindings()
    ),
    GetPage(
        name: _Paths.PROFILE,
        page: () => profile(),
        binding: RootBindings()
    ),
      GetPage(
        name: _Paths.SEARCH,
        page: () => SearchScreen(),
        binding: RootBindings()
    ),
     GetPage(
        name: _Paths.WHISHLIST,
        page: () => WishlistPage(),
        binding: RootBindings()
    ),

  ];
}

