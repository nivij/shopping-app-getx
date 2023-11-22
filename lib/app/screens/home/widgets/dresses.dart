import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../controllers/details_controller.dart';
import '../../../models/product_model.dart';
import 'dress_card.dart';


class ProductListByCategory extends StatelessWidget {
  final String categoryId;
  final DetailsController controller;

  ProductListByCategory({required this.categoryId, required this.controller,});
  @override
  Widget build(BuildContext context) {
    final products = controller.getProductsById(categoryId);
    // final detailsController = Get.put(DetailsController());
    // final WishlistController wishlistController = Get.put(WishlistController());
    int crossAxisCount = _calculateCrossAxisCount(context);

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: MasonryGridView.builder(
        physics: BouncingScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,


          ),
        itemBuilder: (BuildContext context, int index) {
          final Product product = products[index];
          if (crossAxisCount == 3 ) {
            // Special layout for the first item when crossAxisCount is 3
            return Column(
              children: [
                SizedBox(height: 40),
                DressCard(
                  product: product,
                  index: index,
                  photos: product.photos ?? [],
                  name: product.name,
                  description: product.description,
                  price: product.price,
                ),
              ],
            );
          }else {return (index == 1)
              ? Column(
            children: [
              SizedBox(height: 40),
              DressCard(
                product:product,
                index: index,
                photos: product.photos ?? [],
                name: product.name,
                description: product.description,
                price: product.price,
              ),
            ],
          )
              : DressCard(
              index: index,
              photos: product.photos ?? [],
              name: product.name,
              description: product.description,
              price: product.price,
              product: product
          );}

        },

      ),

    );
  }
  int _calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 800) {
      // Desktop
      return 3; // Adjust the count based on your preference
    } else {
      // Mobile or Tablet
      return 2; // Adjust the count based on your preference
    }
  }
}
