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


  @override
  void onInit() {
    super.onInit();
    loadCounter();

  }


  void loadCounter() {
    final savedCounter = box.read('counter');
    if (savedCounter != null) {
      count.value = savedCounter;
    }
  }

  void saveCounter() {
    box.write('counter', count.value);
  }



  void updateCartItemQuantityByIndex(int index, int newQuantity) {
    // Access the OrderController
    final OrderController orderController = Get.find<OrderController>();

    // Access the cartItems from OrderController
    final List<Map<String, dynamic>> cartItems = orderController.cartItems;


      if (index >= 0 && index < cartItems.length) {
        cartItems[index]['quantity'] = newQuantity;
        box.write('cartItems', cartItems);

        orderController.cartItems.refresh();
      }
    }



  void increment() {
    saveCounter();
    count.value++;

  }

  // Function to decrement the counter
  void decrement() {
    if (count.value > 0) {
      count.value--;
      saveCounter();
    }
  }






}