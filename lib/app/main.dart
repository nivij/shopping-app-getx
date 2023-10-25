import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/routes/app_pages.dart';
import 'package:gocart/app/screens/auth_screen.dart';
import 'package:gocart/app/screens/base.dart';
import 'package:gocart/app/screens/binding/root_bindings.dart';
import 'package:gocart/app/screens/tabs/dresses.dart';
import 'package:gocart/app/screens/product_screen.dart';
import 'package:gocart/app/services/themedata.dart';

import 'controllers/theme_controller.dart';

void main() async {
  await GetStorage.init();
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
        title: "Rapid",
        initialBinding: RootBindings(),
        theme: themeController.currentTheme.value, // Set the theme based on the controller
        darkTheme: Darkmode, // Replace with your dark theme if needed
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        initialRoute: AppPages.INITIAL,
      );
    });
  }
}
