import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:gocart/app/widget/dress_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/Wishlist_controller.dart';
import '../../controllers/details_controller.dart';


class ProductListByCategory extends StatelessWidget {
  final String categoryId;
  final DetailsController controller;

  ProductListByCategory({required this.categoryId, required this.controller});
  @override
  Widget build(BuildContext context) {
    final products = controller.getProductsById(categoryId);
    // final detailsController = Get.put(DetailsController());
    // final WishlistController wishlistController = Get.put(WishlistController());

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: MasonryGridView.builder(
        physics: BouncingScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,


          ),
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];

          return (index == 1)
              ? Column(
            children: [
              SizedBox(height: 40),
              DressCard(index: index,
                  product: product
              ),
            ],
          )
              : DressCard(index: index,

              product: product
          );
        },

      ),

    );
  }
}
