import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gocart/app/screens/bottom_navigation/base.dart';

import '../respository/authentication_respositary/authentication_respository.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  void verifyOTP(String otp)async{
    try {
      var isVerified = await AuthenticationRespository.instance.verifyOTP(otp);
      isVerified ? Get.offAll(base()) : Get.back();
    } catch (error) {
      // Handle the exception here
      if (error is PlatformException && error.message == "The given phoneNumber is empty. Please set a non-empty phone number with #setPhoneNumber()") {
        // Handle the specific error
        print("Error: The phone number is empty.");
        Get.showSnackbar(GetSnackBar(
            duration: Duration(seconds: 2),
            message: "fill the fields."));
      } else {
        // Handle other exceptions
        print("Error occurred during OTP verification: $error");
      }
    }
  }
}