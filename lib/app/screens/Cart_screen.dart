import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocart/app/widget/CartCardItem.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/Color_controller.dart';
import '../controllers/Wishlist_controller.dart';
import '../controllers/details_controller.dart';
import '../controllers/order_controller.dart';
import '../models/product_model.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final WishlistController wishlistController = Get.find();
  final detailsController = Get.put(DetailsController());
  final OrderController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    double _currentRating = 4.5;
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

        child:
        Obx(() => SizedBox(
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
              return CartCard(product:product,quantity:quantity ,size:size ,itemcolor:itemColor, index: index,);
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
                      color:Theme.of(context).colorScheme.primary,
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
                        setState(() {
                          // Handle button click logic here
                        });
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
