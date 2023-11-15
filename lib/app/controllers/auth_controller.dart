import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/routes/app_pages.dart';

import '../respository/authentication_respositary/authentication_respository.dart';
import '../respository/authentication_respositary/exception/login_exception.dart';
import '../screens/bottom_navigation/base.dart';

class LoginController extends GetxController{


   static LoginController get instance => Get.find();
   GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

   RxBool showPassword = true.obs;
   final email =TextEditingController();
   final password=TextEditingController();
   final isGoogleLoading =false.obs;

   Future<void> login() async {
     try {
       await AuthenticationRespository.instance.loginWithEmailAndPassword(
           email.text.trim(), password.text.trim());
       Get.offAllNamed(Routes.BASE);
     } catch (e) {
       if (e is LoginWithEmailAndPasswordFailure) {
         Get.showSnackbar(GetSnackBar(message: e.message));
       } else {
         Get.showSnackbar(GetSnackBar(
             duration: Duration(seconds: 2),
             message: "fill the fields."));
       }
     }
   }
Future<void> googleSignIn()
async {
  try{

    isGoogleLoading.value=true;
    final auth=AuthenticationRespository.instance;
     await auth.signInWithGoogle();
     isGoogleLoading.value=false;
    auth.setInitialScreen(auth.firebaseUser.value);

  }catch(e){
    isGoogleLoading.value=false;

  }
}
}