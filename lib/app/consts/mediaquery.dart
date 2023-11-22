import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class mediaQuery{
  static mediaQuery get instance => Get.find();

  double Title(double width) {
    if (width >= 360 && width < 600) {
      // Mobile
      return 25;
    } else if (width >= 600 && width < 800) {
      // Tablet
      return 40;
    } else {
      // Desktop
      return 60;
    }
  }
  double textFieldForm(double width) {
    if (width >= 380 && width < 600) {
      // Mobile
      return double.infinity;
    } else if (width >= 600 && width < 800) {
      // Tablet
      return 100 * 4;
    } else {
      // Desktop
      return 100 * 5;
    }
  }
  double search(double width) {
    if (width >= 380 && width < 600) {
      // Mobile
      return 260;
    } else if (width >= 600 && width < 800) {
      // Tablet
      return 300;
    } else {
      // Desktop
      return 600;
    }
  }
  double dressCardContainerwidth(double width) {
    if (width >= 380 && width < 600) {
      // Mobile
      return  double.infinity;
    } else if (width >= 600 && width < 800) {
      // Tablet
      return 200;
    } else {
      // Desktop
      return 400;
    }
  }
  double dressCardContainerheight(double width) {
    if (width >= 380 && width < 600) {
      // Mobile
      return  325;
    } else if (width >= 600 && width < 800) {
      // Tablet
      return 290;
    } else {
      // Desktop
      return 400;
    }
  }

}