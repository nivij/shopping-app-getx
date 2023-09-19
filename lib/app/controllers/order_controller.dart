import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/product_model.dart';

class OrderController extends GetxController {
  RxList<Modelphoto> cartItems = <Modelphoto>[].obs;
  var count = 0.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }
  showSuccessSnackBar(var title) {
    Get.snackbar(
      animationDuration: Duration(milliseconds: 400),
      duration: Duration(milliseconds: 600),
      'Success',
      title,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }
  void addToCart(Modelphoto item) {
    showSuccessSnackBar(
      'Added To Cart',
    );
    cartItems.add(item);
  }
  var badgeValue = '1'.obs; // Initialize badge value with '0'

  void updateBadgeValue(int count) {
    badgeValue.value = count.toString();
    badgeValue.refresh();
  }
  void removeFromCart(Modelphoto item) {
    showSuccessSnackBar(
      'Removed From  Cart',
    );
    cartItems.remove(item);
  }

  int get cartCount => cartItems.length;
}
