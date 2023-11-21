import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocart/app/routes/app_pages.dart';

import '../respository/authentication_respositary/authentication_respository.dart';
import '../respository/authentication_respositary/exception/login_exception.dart';


class LoginController extends GetxController{


   static LoginController get instance => Get.find();
   GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

   RxBool showPassword = true.obs;
   final email =TextEditingController();
   final password=TextEditingController();
   final isGoogleLoading =false.obs;

   Future<void> login() async {
     try {
       showDialog(
         context: Get.overlayContext!,
         barrierDismissible: false,
         builder: (BuildContext context) {
           return Center(
             child: CircularProgressIndicator(),
           );
         },
       );

       await AuthenticationRespository.instance.loginWithEmailAndPassword(
         email.text.trim(),
         password.text.trim(),
       );

       final auth = AuthenticationRespository.instance;
       if (auth.firebaseUser.value == null) {
         // Show an error message if the user doesn't exist
         Get.showSnackbar(
           GetSnackBar(
             message: "User not found. Please check your credentials.",
           ),
         );
       } else {
         Get.offAllNamed(Routes.BASE);
       }
     } catch (e) {
       if (e is LoginWithEmailAndPasswordFailure) {
         Get.showSnackbar(GetSnackBar(message: e.message));
       } else {
         Get.showSnackbar(
           GetSnackBar(
             duration: Duration(seconds: 2),
             message: "Fill in the fields.",
           ),
         );
       }
     } finally {
       // Close the loading dialog when the operation is done
       Get.back();
     }
   }

   Future<void> googleSignIn() async {
     try {
       showDialog(
         context: Get.overlayContext!,
         barrierDismissible: false,
         builder: (BuildContext context) {
           return Center(
             child: CircularProgressIndicator(),
           );
         },
       );

       isGoogleLoading.value = true;
       final auth = AuthenticationRespository.instance;
       await auth.signInWithGoogle();
       isGoogleLoading.value = false;
       auth.setInitialScreen(auth.firebaseUser.value);
     } catch (e) {
       isGoogleLoading.value = false;
     } finally {
       // Close the loading dialog when the operation is done
       Get.back();
     }
   }

}