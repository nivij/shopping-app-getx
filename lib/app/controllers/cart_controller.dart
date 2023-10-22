import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/models/product_model.dart';
import 'order_controller.dart';

class CartController extends GetxController {
  RxList<Map<String, dynamic>> cart = <Map<String, dynamic>>[].obs;

  final box = GetStorage();
  RxInt count = 0.obs;
  void updateCartItemQuantity(Product item, int newQuantity) {
    // Access the OrderController
    final OrderController orderController = Get.find<OrderController>();

    // Access the cartItems from OrderController
    final List<Map<String, dynamic>> cartItems = orderController.cartItems;
      final itemToUpdate = cartItems.firstWhere((cartItem) {
        final productInCart = Product.fromJson(cartItem['product']);
        return productInCart == item;
      }, orElse: () => {});

      if (itemToUpdate != null) {
        itemToUpdate['quantity'] = newQuantity;

      }
      box.write('cartItems', cartItems);
      // updateBadgeValue();
    orderController.cartItems.refresh();
    // Now you can use cartItems as needed in CartController
  }

  void increment() {
    count.value++;
    // saveCounter();
  }

  // Function to decrement the counter
  void decrement() {
    if (count.value > 0) {
      count.value--;
      // saveCounter();
    }
  }






}