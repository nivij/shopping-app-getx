import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController{

  final GlobalKey<FormState>authFormKey=GlobalKey<FormState>();

  late TextEditingController emailcontroller,passwordcontroller;
  var email ='';
  var password ='';

  @override
  void onInit(){
    super.onInit();
    emailcontroller=TextEditingController();
    passwordcontroller=TextEditingController();
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose(){
    super.onClose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  String? validateEmail(String value){
    if(!GetUtils.isEmail(value)){
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePass(String value){
    if(value.length<6){
      return "Password must be of 6 characters";
    }
    return null;
  }


  void checklogin(){
    final isValid= authFormKey.currentState!.validate();
    if(!isValid){
      return ;
    }
    authFormKey.currentState!.save();
  }
}