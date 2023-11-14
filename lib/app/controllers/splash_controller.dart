import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../respository/authentication_respositary/authentication_respository.dart';
import '../routes/app_pages.dart';
// Import your authentication repository

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    checkAuthentication();
  }

  void checkAuthentication() async {
    final getStorage = GetStorage();
    final authRepository = AuthenticationRespository.instance; // Assuming you have an instance of AuthenticationRespository

    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay for the splash screen

      if (authRepository.firebaseUser.value != null) {
        // User is already logged in, navigate to the dashboard
        Get.offAllNamed(Routes.BASE);
      } else {
        // User is not logged in, navigate to the login screen
        Get.offAllNamed(Routes.LOGIN);
      }
    } catch (e) {
      print("Error during authentication check: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
