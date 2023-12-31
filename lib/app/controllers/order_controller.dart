import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../models/product_model.dart';

class OrderController extends GetxController {
  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  RxInt count = 1.obs;
  int get cartCount => cartItems.length;
  final box = GetStorage();


  void increment() {
    count.value++;

  }

  // Function to decrement the counter
  void decrement() {
    if (count.value > 1) {
      count.value--;

    }
  }
  void resetCounter() {
    count.value = 1;
  }

  var badgeValue = '0'.obs; // Initialize badge value with '0'

  void updateBadgeValue() {
    badgeValue.value = cartCount.toString();
    update();
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
      final productInCart = Product.fromJson(cartItem['product']); // Deserialize the product
      final sizeInCart = cartItem['size'];
      return productInCart == item && sizeInCart == selectedSize;
    });

    if (existingCartItemIndex != -1) {
      cartItems[existingCartItemIndex]['quantity'] += quantity;
    } else {
      // Serialize the Product object to JSON and store it
      cartItems.add({
        'product': item.toJson(), // Serialize the Product object
        'quantity': quantity,
        'size': selectedSize,
      });
    }
    box.write('cartItems', cartItems);
    updateBadgeValue();
    cartItems.refresh();
  }

  void removeFromCart(Product item) {
    final itemToRemove = cartItems.firstWhere((cartItem) {
      final productInCart = Product.fromJson(cartItem['product']); // Deserialize the product
      return productInCart == item;
    }, orElse: () => {});

    if (itemToRemove != null) {
      cartItems.remove(itemToRemove);
      showSuccessSnackBar('Removed From Cart');
    }
    box.write('cartItems', cartItems);
    updateBadgeValue();
    cartItems.refresh();
  }


  bool isItemInCart(Product item) {
    final isItemInCart = cartItems.any((cartItem) {
      final productInCart = Product.fromJson(cartItem['product']);
      return productInCart == item;
    });
    cartItems.refresh(); // Refresh the cartItems list after checking
    return isItemInCart;
  }


  // void updateCartItemQuantity(Product item, int newQuantity) {
  //
  //   final itemToUpdate = cartItems.firstWhere((cartItem) {
  //     final productInCart = Product.fromJson(cartItem['product']);
  //     return productInCart == item;
  //   }, orElse: () => {});
  //
  //   if (itemToUpdate != null) {
  //     itemToUpdate['quantity'] = newQuantity;
  //   }
  //
  //
  //   updateBadgeValue();
  //
  // }

  void loadCartItems() {
    final savedCartItems = box.read('cartItems');
    if (savedCartItems != null) {
      // Cast the dynamic list to List<Map<String, dynamic>>
      cartItems.assignAll(savedCartItems.cast<Map<String, dynamic>>());
    }
    updateBadgeValue();
    cartItems.refresh();
  }
  double getTotalCartPrice() {
    double total = 0.0;
    for (var cartItem in cartItems) {
      final productInCart = Product.fromJson(cartItem['product']);
      final quantity = cartItem['quantity'] as int;
      final price = double.parse(productInCart.price.replaceAll(',', '')); // Remove commas and convert to double

      total += price * quantity;
    }
    return total;

  }
  void clearCart() {
    // Clear the cart list and save it to GetStorage
    cartItems.clear();
    box.write('cartItems', cartItems);

    // You might also want to reset the cart count if you have one
    count.value = 0;
    box.write('counter', count.value);
  }

  @override
  void onInit() {
    super.onInit();

    loadCartItems(); // Load cart items when the controller is initialized
  }
}
