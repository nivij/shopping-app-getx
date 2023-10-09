import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/routes/app_pages.dart';
import 'package:gocart/app/screens/base.dart';

class AuthController extends GetxController{

  final GlobalKey<FormState>authFormKey=GlobalKey<FormState>();
  final getstorage =GetStorage();
  final TextEditingController passwordcontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();
   // password =passwordcontroller.text;



  @override
  void onInit(){
    super.onInit();

    emailcontroller.text = getstorage.read('email') ?? '';
    passwordcontroller.text = getstorage.read('password')?? '';

  }

  @override
  void onReady(){
    super.onReady();
  }


  String? validateEmail(String value){

    if(!GetUtils.isEmail(value)){

        return "Provide valid Email";

    }
    return null;
  }

  String? validatePass(String value){
      if (value.length < 6) {


        return "Password must be of 6 characters";

    }
    return null;
  }


  void checklogin(){
    final isValid= authFormKey.currentState!.validate();
    if(!isValid){
      return ;
    }

    else{
      final email = emailcontroller.text;
      final password = passwordcontroller.text;
      getstorage.write("email", email);
      getstorage.write("password", password);
      Get.offAllNamed(Routes.BASE);
    }
    authFormKey.currentState!.save();
  }
  void logout() {

    getstorage.remove('email');
    getstorage.remove('password');
    emailcontroller.clear(); // Clear the text field
    passwordcontroller.clear();
    emailcontroller.dispose();
    passwordcontroller.dispose();

    // Optionally, navigate back to the login screen or any other desired route
    Get.offAllNamed(Routes.LOGIN);
  }

}