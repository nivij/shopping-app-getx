import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/Wishlis_controller.dart';
import '../controllers/details_controller.dart';

class WishlistPage extends StatelessWidget {
  final WishlistController wishlistController = Get.find();
  final detailsController = Get.put(DetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: wishlistController.wishlist.length,
          itemBuilder: (context, index) {
            final wishlistItem = wishlistController.wishlist[index];
            return ListTile(
              leading: Image.asset(
                  wishlistItem.product.photo),
              title: Text(wishlistItem.product.name),
              subtitle: Text(
                  '\$${wishlistItem.product.price}'),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  wishlistController.removeFromWishlist(
                      wishlistItem.product);

                },
              ),
            );
          },
        ),
      ),
    );
  }
}