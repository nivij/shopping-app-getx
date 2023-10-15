import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gocart/app/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import '../controllers/Color_controller.dart';
import '../controllers/Wishlist_controller.dart';
import '../controllers/details_controller.dart';
import '../controllers/order_controller.dart';
import '../widget/test.dart';

class WishlistPage extends StatefulWidget {
  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistController wishlistController = Get.find();

  final detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    double _currentRating = 4.5;
    final colorcontroller = Get.put(ColorController());
    final DetailsController Product = Get.put(DetailsController());
    final OrderController orderController = Get.put(OrderController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('Wishlist',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w700)),
          actions: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: 1, end: 8),
              badgeAnimation: badges.BadgeAnimation.fade(),
              showBadge: true,
              badgeContent:
                  Text("11", style: GoogleFonts.poppins(fontSize: 17)),
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 15),
                child: Icon(Typicons.bell, color: Colors.black, size: 25),
              ),
            ),
          ],
        ),
        body: Obx(() => ListView.builder(
              itemCount: wishlistController.wishlist.length,
              itemBuilder: (context, index) {
                int colorIndex = index %
                    colorcontroller
                        .colorlist.length; // Use modulo to cycle through colors
                Color itemColor = colorcontroller.colorlist[colorIndex];
                final wishlistItem = wishlistController.wishlist[index];
                return Bounceable(
                  onTap: () {
                    Get.to(ProductScreen(
                        index: index,
                        colors: itemColor,
                        photo: wishlistItem.product.photo,
                        product: wishlistItem.product
                    ));
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
                            child: Image.asset(wishlistItem.product.photo),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(wishlistItem.product.name,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Text("Review",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomRatingBar(
                                      maxRating: 1,
                                      initialRating: 3.5,
                                      onRatingChanged: (newRating) {
                                        setState(() {
                                          _currentRating = newRating;
                                        });
                                      },
                                    ),
                                    Text(
                                      "$_currentRating ",
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
                                Text('\$${wishlistItem.product.price}',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(),
                                      width: 130,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.transparent,
                                              shadowColor: Colors.transparent),
                                          onPressed: () {
                                              setState(() {

                                                // orderController.addToCart(wishlistItem.product);

                                              });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/shopping-bag.png",
                                                color: Colors.white,
                                                height: 12,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Add to cart",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700))
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(),
                                      width: 40,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: IconButton(
                                        icon: Icon(MfgLabs.heart_broken,
                                            color: Colors.white, size: 20),
                                        onPressed: () {
                                          wishlistController.removeFromWishlist(
                                              wishlistItem.product);
                                        },
                                      ),
                                    ),
                                  ],
                                )
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
