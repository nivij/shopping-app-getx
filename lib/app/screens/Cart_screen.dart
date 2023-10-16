import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gocart/app/screens/product_screen.dart';
import 'package:gocart/app/widget/counter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import '../controllers/Color_controller.dart';
import '../controllers/Wishlist_controller.dart';
import '../controllers/details_controller.dart';
import '../controllers/order_controller.dart';
import '../models/product_model.dart';
import '../widget/test.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final WishlistController wishlistController = Get.find();

  final detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    double _currentRating = 4.5;
    final OrderController cartController = Get.find();
    final colorcontroller = Get.put(ColorController());

    return Scaffold(
      // bottomSheet: Container(
      //   height: 200,
      //   color: Colors.black,
      // ),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('Cart',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w700)),

        ),
        body: Obx(() => ListView.builder(
          itemCount:cartController.cartItems.length,

          itemBuilder: (context, index) {
            int colorIndex = index %
                colorcontroller
                    .colorlist.length; // Use modulo to cycle through colors
            Color itemColor = colorcontroller.colorlist[colorIndex];
            final cartItem = cartController.cartItems[index];
            final product = Product.fromJson(cartItem['product']); // Use your fromJson factory constructor
            final quantity = cartItem['quantity'] as int;
            final size = cartItem['size'] as String;
            return Bounceable(
              onTap: () {
                // Get.to(ProductScreen(
                //     index: index,
                //     colors: itemColor,
                //     photo: wishlistItem.product.photo,
                //     product: wishlistItem.product
                // ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.transparent,
                  height: 150,
                  child: Row(
                    children: [
                      Container(
                        height: 130,
                        width: 120,
                        decoration: BoxDecoration(
                            color: itemColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(product.photo),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 195,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Bounceable(
                                      onTap: () {
                                        cartController.removeFromCart(product);

                                      },
                                      child: Icon(Elusive.cancel_circled)),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text("Size : ",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),

                                Text(
                                  "$size",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text("Quantity : ",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                                Text('$quantity',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),

                            SizedBox(
                              height: 7,
                            ),

                            Row(
                              children: [
                                Text('\$${product.price}',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                             SizedBox(width: 40,),
                             Counter()

                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )));
  }
}
