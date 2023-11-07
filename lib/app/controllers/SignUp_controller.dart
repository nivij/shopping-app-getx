import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController{
  static SignupController get instance=> Get.find();


  final email =TextEditingController();
  final fullname =TextEditingController();
  final password =TextEditingController();

   void registerUser(String email,String password){

   }


}