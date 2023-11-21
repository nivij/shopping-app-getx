import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class mediaQuery{
  static mediaQuery get instance => Get.find();

  double Title(double width) {
    if (width >= 380 && width < 600) {
      // Mobile
      return 20;
    } else if (width >= 600 && width < 800) {
      // Tablet
      return 40;
    } else {
      // Desktop
      return 70;
    }
  }
}