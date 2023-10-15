import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';
import '../models/product_model.dart';

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
          final cartItem = cartController.cartItems[index];
          final product = cartItem['product'] as Product;
          final quantity = cartItem['quantity'] as int;
          final size = cartItem['size'] as String;

          return ListTile(
            leading: Image.asset(product.photo),
            title: Text(product.name),
            subtitle: Text("Size: $size, Quantity: $quantity"),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                cartController.removeFromCart(product);
              },
            ),
          );
        },
      )),
    );
  }
}
