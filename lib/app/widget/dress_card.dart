import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/Color_controller.dart';
import '../controllers/Wishlis_controller.dart';
import '../controllers/details_controller.dart';

class DressCard extends StatefulWidget {
  final index;
  final detailsList;
  final product;

  const DressCard({
    super.key,
    this.index,
    this.detailsList, this.product,
  });

  @override
  State<DressCard> createState() => _DressCardState();
}

class _DressCardState extends State<DressCard> {
  // int choice = 0;
  bool isWishlistItem = false;
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    final productIndex = widget.index;
    // Retrieve the wishlist state from Get Storage and initialize isWishlistItem
    isWishlistItem = box.read('isWishlistItem$productIndex') ?? false;


  }

  @override
  Widget build(BuildContext context) {

    final WishlistController wishlistController = Get.find();
    final detailsController = Get.put(DetailsController());
    final colorcontroller = Get.put(ColorController());
    int colorIndex = widget.index % colorcontroller.colorlist.length; // Use modulo to cycle through colors
    Color itemColor = colorcontroller.colorlist[colorIndex];
    return InkWell(
      onTap: () {
        Get.to(
          ProductScreen(
            index: widget.index,
            colors: colorcontroller.colorlist,
            photo: widget.product.photo,
            product: widget.product
          ),
          // arguments: [colorcontroller.colorlist, colorcontroller.colorlist]
        );
      },

      child: Container(
        height: 325,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(children: [
                    Container(
                      color: itemColor,
                      height: 200,
                      width: 164,
                      child: Image.asset(
                          widget.product.photo),
                    ),
                    Positioned(
                        top: 10,
                        left: 100,
                        child: SizedBox(
                          height: 28,
                          child: Obx(
                                () {
                              bool isWishlistItem = wishlistController.isInWishlist(widget.product);

                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  backgroundColor: Colors.black,
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  if (isWishlistItem) {
                                    box.remove('isWishlistItem${widget.product.id}');
                                    wishlistController.removeFromWishlist(widget.product);
                                  } else {
                                    wishlistController.addToWishlist(widget.product);
                                    box.write('isWishlistItem${widget.product.id}', true);
                                  }
                                },
                                child: Icon(
                                  isWishlistItem
                                      ? FluentIcons.heart_24_filled
                                      : FluentIcons.heart_32_regular,
                                  color: CupertinoColors.white,
                                  size: 20,
                                ),
                              );
                            },
                          )

                        ))
                  ])),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.product.name  ,
                  style: GoogleFonts.poppins(
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.w600,

                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                widget.product.description,textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                    color: CupertinoColors.black.withOpacity(0.4),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                 '\$ ${widget.product.price}',
                  style: GoogleFonts.poppins(
                    color: CupertinoColors.black, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
