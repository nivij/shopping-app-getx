import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/screens/base.dart';
import 'package:gocart/app/screens/binding/root_bindings.dart';
import 'package:gocart/app/screens/home_screen.dart';
import 'package:gocart/app/screens/product_screen.dart';


void main() async {
  await GetStorage.init();
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Rapid",
      initialBinding: RootBindings(),
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: base(),
      getPages: [
        GetPage(
            name: '/home_screen', page: () => home(), binding: RootBindings()),
      GetPage(name: '/product_screen', page: () => ProductScreen(),binding: RootBindings())
      ],

    );
  }
}
