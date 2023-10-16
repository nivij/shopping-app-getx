import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/controllers/Size_controller.dart';
import 'package:gocart/app/screens/whislist_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/Wishlist_controller.dart';
import '../controllers/details_controller.dart';
import '../controllers/order_controller.dart';
import '../widget/counter.dart';
import '../widget/test.dart';
import 'Cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final index;
  final colors;
  final photo;
  final product;
  const ProductScreen(
      {super.key, this.index, this.colors, this.photo, this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isWishlistItem = false;
  int selectedSizeIndex = 0;
  // var data = Get.arguments;
  final box = GetStorage();
  double _currentRating = 4.5; // Initial rating value
  String selectedSize = '';
  double get currentRating => _currentRating;
  @override

  void initState() {

    final OrderController orderController = Get.put(OrderController());
    super.initState();
    final productIndex = widget.index;
    orderController.updateBadgeValue();
    orderController.resetCounter();
    // Retrieve the wishlist state from Get Storage and initialize isWishlistItem
    isWishlistItem = box.read('isWishlistItem$productIndex') ?? false;

  }

  @override
  Widget build(BuildContext context) {
    final sizecontroller = Get.put(SizeController());
    final detailsController = Get.put(DetailsController());
    final WishlistController wishlistController = Get.find();
     final OrderController orderController = Get.put(OrderController());
     return Scaffold(
        backgroundColor: widget.colors,
        body: SafeArea(
          child: Stack(

            children: [
              Positioned(
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 400.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(widget.photo,),),),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top:-21,
                left: -10,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: IconButton(
                    padding: EdgeInsets.all(30),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Container(
                        width: 40, // Set the desired width
                        height: 40, // Set the desired height
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          "assets/left-arrow.png",
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 20,
                child: Obx(() {
                  return badges.Badge(
                     badgeStyle: badges.BadgeStyle(
                       badgeColor: Colors.black
                     ),
                    badgeAnimation: badges.BadgeAnimation.fade(),
                    showBadge: orderController.badgeValue == '0' ? false : true,
                    badgeContent:  Text(
                        orderController.badgeValue.value,
                        style: TextStyle(
                          color: Colors.white, // Text color
                        ),
                    ),
                    child: Bounceable(
                      onTap: () {
                        Get.to(CartPage());
                      },
                      child: Container(
                        width: 40, // Set the desired width
                        height: 40, // Set the desired height
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          "assets/shopping-bag.png",
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                })


              ),

              Positioned(
                top: -20,
                bottom: 0,
                right: -13,
                child: SizedBox(
                  height: 10,
                  width: 90,

                  child: FittedBox(
                    child: IconButton(
                      style: IconButton.styleFrom(
                        
                      ),
                      padding: EdgeInsets.all(13),
                      onPressed: () {
                        setState(() {
                          if (isWishlistItem) {
                            box.remove('isWishlistItem${widget.product.id}');
                            wishlistController.removeFromWishlist(widget.product);
                            // Remove the state from Get Storage when removing from wishlist
                          } else {
                            wishlistController.addToWishlist(widget.product);
                            // Save the wishlist state in Get Storage when adding to wishlist
                            box.write('isWishlistItem${widget.product.id}', true);
                          }

                          isWishlistItem = !isWishlistItem;
                        });
                      },
                      icon: Container(
                          width: 35, // Set the desired width
                          height: 35, // Set the desired height
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image.asset(
                            (isWishlistItem == true)
                                ? "assets/heartfilled.png"
                                : "assets/heart.png",
                            color: Colors.black,
                          )),
                    ),
                  ),
                ),
              ),
              Positioned(
                // top: 360,
                bottom: -10,
                left: 0,
                right: 0,
                child: Container(
                  height: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15,top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text( widget.product.name,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                            Counter()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomRatingBar(
                              maxRating: 5,
                              initialRating: 3.5,
                              onRatingChanged: (newRating) {
                                print('New Rating: $newRating');
                                setState(() {
                                  _currentRating = newRating;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "($_currentRating )",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Size",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sizecontroller.sizelist.length,
                            itemBuilder: (context, index) {
                              bool isSelected = index ==
                                  selectedSizeIndex; // Check if this size is selected

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = sizecontroller.sizelist[index].size; // Update selectedSize
                                    selectedSizeIndex = index;// Update the selected size index
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 45,
                                  margin: EdgeInsets.only(right: 13),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors
                                              .transparent, // Change color based on selection
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.black)),
                                  child: Text(
                                    sizecontroller.sizelist[index].size,
                                    style: GoogleFonts.poppins(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors
                                              .grey, // Change text color based on selection
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Description",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.product.description,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.left,
                        ),
                       SizedBox(height: 20,),


                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    bottomNavigationBar:  Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ Text("Total price", style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w500
            )),
              Text('\₹ ${widget.product.price}',style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),),
            ],
          ),

          Container(
            padding: EdgeInsets.only(),
            width: 180,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40)
            ),
            child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                    elevation: 0,

                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent

                ),
                onPressed: () {
                       setState(() {
                         orderController.updateBadgeValue();
                         orderController.addToCart(widget.product, orderController.count.value, selectedSize);
                       });

                }, child: Row(
              mainAxisAlignment:MainAxisAlignment.center ,


              children: [
                Image.asset(
                  "assets/shopping-bag.png",
                  color: Colors.white,height: 25,
                ),
                SizedBox(width: 10,),
                Text("Add to cart",style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700))
              ],
            )),
          )
        ],
      ),
    ),
    );
  }
}
