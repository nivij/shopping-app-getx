import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';
import 'package:gocart/app/controllers/order_controller.dart';
import 'package:gocart/app/models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/cart_controller.dart';

class CartCard extends StatelessWidget {
late int index;
final product;
final size;
final itemcolor;
final quantity;

 CartCard({ Key? key,
    required this.index,
    required this.product,
    required this.quantity,
    required this.size,
    required this.itemcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderController orderController= Get.find();
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
                  color: itemcolor,
                  borderRadius: BorderRadius.circular(20),
                ),
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
                              orderController.removeFromCart(product);
                            },
                            child: Icon(Elusive.cancel_circled),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          "Size : ",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "$size",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          "Quantity : ",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '$quantity',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),


                      ],
                    ),

                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${product.price}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        _counter()
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
  }
  Widget _counter(){

    final CartController cartController = Get.find();
    return  Obx(() => Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.only(left: 10),
            onPressed: () {
              cartController.decrement();
              // widget.orderController.saveCounter();

              cartController.updateCartItemQuantity(product, cartController.count.value,); // Pass the size here
            },
            icon: Icon(
              Icons.remove,
              color: Colors.black,
            ),
          ),
          Text(
            '${cartController.count.value}',
            style: GoogleFonts.poppins(fontSize: 18),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 19),
            onPressed: () {
              // widget.orderController.saveCounter();
              cartController.updateCartItemQuantity(product, cartController.count.value + 1, ); // Pass the size here

              cartController.increment();
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ));
  }
}
