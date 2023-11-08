import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:gocart/app/controllers/SignUp_controller.dart';
import 'package:gocart/app/controllers/Wishlist_controller.dart';
import 'package:gocart/app/controllers/auth_controller.dart';
import 'package:gocart/app/controllers/cart_controller.dart';
import 'package:gocart/app/controllers/details_controller.dart';
import 'package:gocart/app/controllers/order_controller.dart';
import 'package:gocart/app/controllers/text_controller.dart';

import '../controllers/Color_controller.dart';
import '../controllers/Size_controller.dart';
import '../controllers/splash_controller.dart';


class RootBindings implements Bindings {

  @override
  void dependencies() {
    Get.put(DetailsController());
    Get.lazyPut(() => TextController(),);
    Get.lazyPut(() => ColorController(),);
    Get.put( OrderController(),);
    Get.lazyPut(() => WishlistController(),);
    Get.lazyPut(() => SizeController(),);
    Get.lazyPut(() => AuthController(),);
    Get.put(SplashController());
    Get.put(CartController());
    Get.put(SignupController());


  }
}
