
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gocart/app/screens/authentication/Signup_screen.dart';
import 'package:gocart/app/screens/authentication/splash_screen.dart';

import '../binding/root_bindings.dart';
import '../screens/cart/Cart_screen.dart';
import '../screens/home/Search_screen.dart';
import '../screens/authentication/login/login_screen.dart';
import '../screens/bottom_navigation/base.dart';

import '../screens/myorder/myorder_screen.dart';
import '../screens/product_details/product_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/track_order/timeline_screen.dart';
import '../screens/wishlist/wishlist_screen.dart';
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
        page: () => login(),
        binding: RootBindings()
    ), GetPage(
        name: _Paths.SPLASH,
        page: () => Splash(),
        binding: RootBindings()
    ),
    GetPage(
        name: _Paths.PRODUCTVIEW,
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
    GetPage(
        name: _Paths.ORDER,
        page: () => OrderConfirmationScreen(),
        binding: RootBindings()
    ),
 GetPage(
        name: _Paths.SIGNUP,
        page: () => SignupPage(),
        binding: RootBindings()
    ),


  ];
}

