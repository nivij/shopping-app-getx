import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/widget/CartCardItem.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/Color_controller.dart';
import '../controllers/Wishlist_controller.dart';
import '../controllers/details_controller.dart';
import '../controllers/order_controller.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

import 'myorder_screen.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic>? paymentIntent;
  final GetStorage box = GetStorage();
  final OrderController cartController = Get.find();
  List<Map<String, dynamic>> cartItemsAtPayment = [];

  Future<void> makePayment() async {
    try {
      int totalAmountInCents = (cartController.getTotalCartPrice() * 100).toInt();
      cartItemsAtPayment = List<Map<String, dynamic>>.from(cartController.cartItems);


      paymentIntent = await createPaymentIntent(totalAmountInCents.toString(), 'INR');
      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: "INR", currencyCode: "INR", testEnv: true);
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  // style: ThemeMode.light,
                  merchantDisplayName: 'Nivij',
                  googlePay: gpay))
          .then((value) {
        return displayPaymentSheet();
      });

      //STEP 3: Display Payment sheet
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51O4eNqSBlVVnbSrglcqBKNOdjHfGcmq29VCpbzAl9hDBQWLdgntSM3rQJG8UUz5nLzdGvjePgU3NcJXmPU8I4R8200VOwqW9EM',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet() async {
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
        box.write('cartItemsAtPayment', cartItemsAtPayment);
       Get.to(OrderConfirmationScreen());
        cartController.clearCart();
        setState(() {
          paymentIntent = null;
        });
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

  final WishlistController wishlistController = Get.find();
  final detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    final OrderController cartController = Get.find();
    final colorcontroller = Get.put(ColorController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Cart',
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => SizedBox(
              height: 490,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  int colorIndex = index % colorcontroller.colorlist.length;
                  Color itemColor = colorcontroller.colorlist[colorIndex];
                  final cartItem = cartController.cartItems[index];
                  final product = Product.fromJson(cartItem['product']);
                  final quantity = cartItem['quantity'];
                  final size = cartItem['size'] as String;
                  return CartCard(
                    product: product,
                    quantity: quantity,
                    size: size,
                    itemcolor: itemColor,
                    index: index,
                  );
                },
              ),
            )),
      ),
      bottomSheet: Obx(() {
        return Visibility(
          visible: cartController.cartItems.isNotEmpty,
          child: Container(
            height: 140,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Text(
                    "Total Price   :   ",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Text(
                    "\₹  ${cartController.getTotalCartPrice().toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    padding: EdgeInsets.only(),
                    width: 180,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        makePayment();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/checkout.png",
                            color: Theme.of(context).colorScheme.secondary,
                            height: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Checkout",
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
