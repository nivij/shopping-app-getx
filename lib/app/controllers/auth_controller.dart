import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/routes/app_pages.dart';

import '../respository/authentication_respositary/authentication_respository.dart';
import '../screens/bottom_navigation/base.dart';

class LoginController extends GetxController{


   static LoginController get instance => Get.find();
   RxBool showPassword = true.obs;
   final email =TextEditingController();
   final password=TextEditingController();

   Future<void> login() async {
     try {
       await AuthenticationRespository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
       Get.offAllNamed(Routes.BASE);
     } catch (e) {
       Get.showSnackbar(GetSnackBar(message: e.toString()));
     }
   }

}