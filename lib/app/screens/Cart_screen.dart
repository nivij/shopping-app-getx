import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart'; // Import your OrderController
import '../models/product_model.dart'; // Import your Modelphoto class

class CartPage extends StatelessWidget {
  final OrderController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Obx(() => ListView.builder(
        itemCount: cartController.cartItems.length,
        itemBuilder: (context, index) {
          final item = cartController.cartItems[index];
          return ListTile(
            title: Text(cartController.cartItems[index].name),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                cartController.removeFromCart(item);
              },
            ),
          );
        },
      )),
    );
  }
}



