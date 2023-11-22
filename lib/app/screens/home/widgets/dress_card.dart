import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/consts/mediaquery.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../controllers/Color_controller.dart';
import '../../../controllers/Wishlist_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../models/product_model.dart';

class DressCard extends StatefulWidget {
  final int index;
  final List<String> photos;
  final String name;
  final String description;
  final String price;
  final Product product;

  const DressCard({
    Key? key,
    required this.index,
    required this.photos,
    required this.name,
    required this.description,
    required this.price,
    required this.product,
  });

  @override
  State<DressCard> createState() => _DressCardState();
}

class _DressCardState extends State<DressCard> {
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
    final colorController = Get.put(ColorController());
    int colorIndex = widget.index % colorController.colorlist.length;
    Color itemColor = colorController.colorlist[colorIndex];

    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCTVIEW,
          arguments: {
            'index': widget.index,
            'color': itemColor,
            'photos': widget.photos,
            'product': widget.product,
          },
        );
      },
      child: Container(
        height: screenWidth >= 800 ? 400 : 325,
        width: mediaQuery.instance.dressCardContainerwidth(screenWidth),// Adjust the height based on your needs
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    Container(
                      color: itemColor,
                      height: screenWidth >= 800 ? 300 : 200,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlayCurve: Curves.easeInOut,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                        ),
                        items: (widget.photos ?? []).map((photo) {
                          return Container(
                            width: screenWidth >= 800 ? 250 : double.infinity,
                            child: Image.asset(
                              photo, // Assuming that the photos are asset paths
                              fit: BoxFit.fitWidth,
                              height: screenWidth >= 800 ? 10 : 200, // Adjust the image height for larger screens
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(
                      top: screenWidth >= 800 ? 20 : screenWidth >= 600 ? 15 : 10,
                      left: screenWidth >= 1130 ? 300 : screenWidth >= 800 ?220 : 100,
                      child: SizedBox(
                        height: 28,
                        child: Obx(
                              () {
                            bool isWishlistItem =
                            wishlistController.isInWishlist(widget.product);

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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.product.name,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                widget.product.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\₹ ${widget.product.price}',
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
