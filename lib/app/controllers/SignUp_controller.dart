import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gocart/app/respository/authentication_respositary/authentication_respository.dart';

class SignupController extends GetxController{
  static SignupController get instance=> Get.find();


  final email =TextEditingController();
  final fullname =TextEditingController();
  final password =TextEditingController();

   void registerUser(String email,String password){
  AuthenticationRespository.instance.createUserWithEmailAndPassword(email, password);
   }


}