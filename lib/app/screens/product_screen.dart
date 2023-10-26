import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/controllers/Size_controller.dart';
import 'package:gocart/app/screens/wishlist_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/Wishlist_controller.dart';
import '../controllers/details_controller.dart';
import '../controllers/order_controller.dart';
import '../routes/app_pages.dart';
import '../widget/counter.dart';
import '../widget/Custom_rating_bar.dart';
import 'Cart_screen.dart';

class ProductScreen extends StatefulWidget {

  const ProductScreen(
      {super.key,});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final sizecontroller = Get.put(SizeController());
  bool isWishlistItem = false;
  int selectedSizeIndex = 0;
  // var data = Get.arguments;
  final box = GetStorage();
  double _currentRating = 4.5; // Initial rating value
   late String selectedSize;
  double get currentRating => _currentRating;
  @override

  @override
  void initState() {
    super.initState();
    final sizecontroller = Get.put(SizeController());
    selectedSize = sizecontroller.sizelist[0].size;
    final OrderController orderController = Get.put(OrderController());

    // Retrieve the arguments and ensure it's not null
    final Map<String, dynamic> arguments = Get.arguments;

    if (arguments != null) {
      final index = arguments['index'];

      final productIndex = index;
      orderController.updateBadgeValue();
      orderController.resetCounter();

      // Retrieve the wishlist state from Get Storage and initialize isWishlistItem
      isWishlistItem = box.read('isWishlistItem$productIndex') ?? false;
    }

  }


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;

    final colors = arguments['color'];
    final List<String> photos = arguments['photos'];
    final product = arguments['product'];

    final sizecontroller = Get.put(SizeController());
    final WishlistController wishlistController = Get.find();
     final OrderController orderController = Get.put(OrderController());
     return Scaffold(
        backgroundColor: colors,
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
                            child: CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 500,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 4),
                              ),
                              items: (photos ?? []).map((photo) {
                                return Container(

                                  width: double.infinity,
                                  child: Image.asset(
                                    photo,
                                    fit: BoxFit.fitHeight,
                                    // Set the fit property to cover
                                    // Set a fixed height
                                  ),
                                );
                              }).toList(),
                            ),
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
                        Get.toNamed(Routes.CART);

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
                            box.remove('isWishlistItem${product.id}');
                            wishlistController.removeFromWishlist(product);
                            // Remove the state from Get Storage when removing from wishlist
                          } else {
                            wishlistController.addToWishlist(product);
                            // Save the wishlist state in Get Storage when adding to wishlist
                            box.write('isWishlistItem${product.id}', true);
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
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15,top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text( product.name,
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                            Counter(orderController: orderController, product: product,)
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
                                  color: Theme.of(context).colorScheme.primary,
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
                              color: Theme.of(context).colorScheme.primary,
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
                                          ? Theme.of(context).colorScheme.secondaryContainer
                                          : Colors
                                              .transparent, // Change color based on selection
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Theme.of(context).colorScheme.outline)),
                                  child: Text(
                                    sizecontroller.sizelist[index].size,
                                    style: GoogleFonts.poppins(
                                      color: isSelected
                                          ? Theme.of(context).colorScheme.secondary
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
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.description,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.primary,
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
      color: Theme.of(context).colorScheme.secondary,
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
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500
            )),
              Text('\₹  ${product.price}',style: GoogleFonts.poppins(
                  fontSize: 20,
                  color:Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700),),
            ],
          ),

          Container(
            padding: EdgeInsets.only(),
            width: 180,
            height: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
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
                         orderController.addToCart(product, orderController.count.value, selectedSize);
                       });

                }, child: Row(
              mainAxisAlignment:MainAxisAlignment.center ,


              children: [
                Image.asset(
                  "assets/shopping-bag.png",
                  color: Theme.of(context).colorScheme.secondary,height: 25,
                ),
                SizedBox(width: 10,),
                Text("Add to cart",style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.secondary,
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
