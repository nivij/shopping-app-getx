import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/routes/app_pages.dart';
import 'package:gocart/app/screens/binding/root_bindings.dart';
import 'controllers/theme_controller.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51O4eNqSBlVVnbSrgqTTHYvP4m0nqUhYVCiqNLhOiguZ1sEKw1G3K1bTW5KaiTneHVS7dZijpU5oJLvCS6qBDormU00W8JGFrx8';

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(() {
      return GetMaterialApp(
        title: "Go cart",
        initialBinding: RootBindings(),
        theme: themeController.currentTheme.value, // Set the theme based on the controller
         // Replace with your dark theme if needed
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        initialRoute: AppPages.INITIAL,
      );
    });
  }
}
