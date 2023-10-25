import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/themedata.dart';

class ThemeController extends GetxController {

  Rx<ThemeData> currentTheme = Lightmode.obs;


  void toggleTheme() {
    if (currentTheme.value == Lightmode) {
      print("true");
      currentTheme.value = Darkmode;
    } else {
      print("false");
      currentTheme.value = Lightmode;
    }
  }
}