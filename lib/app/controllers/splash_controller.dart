

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';


import '../routes/app_pages.dart';

class SplashController extends GetxController {

@override
  void onReady() {
  final getstorage =GetStorage();

  // print("Email from getstorage: $email");
  // if (getstorage.read("email") != null) {
  //   Future.delayed(Duration(milliseconds: 2000), () {
  //     Get.offAllNamed(Routes.BASE);
  //
  //   });
  //
  // }
  // else {

    Get.offAllNamed(Routes.LOGIN);
  // }



}
@override
  void onInit() {


  super.onInit();

  }

}