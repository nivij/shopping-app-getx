import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/myorder_screen.dart';
import 'order_controller.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
class CartController extends GetxController {
  RxList<Map<String, dynamic>> cart = <Map<String, dynamic>>[].obs;
  Map<String, dynamic>? paymentIntent;
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

  Future<void> makePayment(BuildContext context) async {
    try {
      final OrderController orderController = Get.find<OrderController>();
      int totalAmountInCents = (orderController.getTotalCartPrice() * 100).toInt();
      List<Map<String, dynamic>> cartItemsAtPayment = List<Map<String, dynamic>>.from(orderController.cartItems);

      final DateTime now = DateTime.now();

      // Add a timestamp to each item in cartItemsAtPayment
      for (final item in cartItemsAtPayment) {
        item['timestamp'] = now.toUtc().toIso8601String(); // Save timestamp as an ISO 8601 string
      }



      final paymentIntent = await createPaymentIntent(totalAmountInCents.toString(), 'INR');
      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: "INR", currencyCode: "INR", testEnv: true);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Nivij',
          googlePay: gpay,
        ),
      );

      await displayPaymentSheet(context, cartItemsAtPayment);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> displayPaymentSheet(BuildContext context,List<Map<String, dynamic>> cartItemsAtPayment) async {
    final OrderController orderController = Get.find<OrderController>();
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                ],
              ),
            ));
        final existingCartItemsAtPayment = box.read('cartItemsAtPayment') ?? [];

        // Merge existing data with new data
        final updatedCartItemsAtPayment = List<Map<String, dynamic>>.from(existingCartItemsAtPayment)
          ..addAll(cartItemsAtPayment);

        // Write the merged data back
        box.write('cartItemsAtPayment', updatedCartItemsAtPayment);
        Get.to(OrderConfirmationScreen());
        orderController.clearCart();

          paymentIntent = null;

      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      // Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      // Make a post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51O4eNqSBlVVnbSrglcqBKNOdjHfGcmq29VCpbzAl9hDBQWLdgntSM3rQJG8UUz5nLzdGvjePgU3NcJXmPU8I4R8200VOwqW9EM',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }


  }






