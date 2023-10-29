import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gocart/app/widget/dress_card.dart';
import '../../controllers/details_controller.dart';
import '../../models/product_model.dart';


class ProductListByCategory extends StatelessWidget {
  final String categoryId;
  final DetailsController controller;

  ProductListByCategory({required this.categoryId, required this.controller,});
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
          final Product product = products[index];

          return (index == 1)
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
          );
        },

      ),

    );
  }
}
