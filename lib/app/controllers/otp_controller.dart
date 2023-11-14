import 'package:get/get.dart';
import 'package:gocart/app/screens/bottom_navigation/base.dart';

import '../respository/authentication_respositary/authentication_respository.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  void verifyOTP(String otp)async{
    var isVerified= await AuthenticationRespository.instance.verifyOTP(otp);
  isVerified ?Get.offAll(base()) : Get.back();
  }
}