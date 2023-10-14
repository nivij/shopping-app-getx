import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../models/product_model.dart';

class OrderController extends GetxController {
  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  var count = 0.obs;
  late Product _item;
  int get cartCount => cartItems.length;
  final box = GetStorage();
  void increment() {
    count.value++;

  }

  // Function to decrement the counter
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
  void addToCart(Product item, int quantity, String selectedSize) {
    showSuccessSnackBar('Added To Cart');
    final existingCartItemIndex = cartItems.indexWhere((cartItem) {
      final productInCart = cartItem['product'] as Product;
      final sizeInCart = cartItem['size'] as String;
      return productInCart == item && sizeInCart == selectedSize;
    });

    if (existingCartItemIndex != -1) {
      // If the item with the same product and size is already in the cart, update its quantity
      cartItems[existingCartItemIndex]['quantity'] += quantity;
    } else {
      // If the item is not in the cart, add it with the specified quantity and size
      cartItems.add({
        'product': item,
        'quantity': quantity,
        'size': selectedSize,
      });
    }
    updateBadgeValue();
  }
  void resetCounter() {
    count.value = 0;
  }

  var badgeValue = '0'.obs; // Initialize badge value with '0'

  void updateBadgeValue() {
    badgeValue.value = cartCount.toString();
  }
  void removeFromCart(Product item) {
    final itemToRemove = cartItems.firstWhere((cartItem) {
      final productInCart = cartItem['product'] as Product;
      return productInCart == item;
    }, orElse: () => {});

    if (itemToRemove.isNotEmpty) {
      cartItems.remove(itemToRemove);
      showSuccessSnackBar('Removed From Cart');
    }
    updateBadgeValue();
  }


}
