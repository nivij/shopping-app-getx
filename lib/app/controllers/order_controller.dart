import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/product_model.dart';

class OrderController extends GetxController {
  RxList<Dresses> cartItems = <Dresses>[].obs;
  var count = 0.obs;
  late Dresses _item;

  Dresses get getitem => _item;

  void increment(Dresses item) {
    cartItems.removeWhere((Dresses selectedItem) => selectedItem.id == item.id);
  item.qty++;
  cartItems.add(item);

  }

  void decrement(Dresses item) {
    if(item.qty==1){
      cartItems.removeWhere((Dresses selectedItem) => selectedItem.id == item.id);
      }
    else {
      cartItems.removeWhere((Dresses selectedItem) => selectedItem.id == item.id);
    item.qty--;
    cartItems.add(item);
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
  void addToCart(Dresses item) {
    showSuccessSnackBar(
      'Added To Cart',
    );
    cartItems.add(item);
  }
  var badgeValue = '0'.obs; // Initialize badge value with '0'

  void updateBadgeValue( count ) {
    badgeValue.value = count.toString();

  }
  void removeFromCart(Dresses item) {
    showSuccessSnackBar(
      'Removed From  Cart',
    );
    cartItems.remove(item);
  }

  int get cartCount => cartItems.length;
}
