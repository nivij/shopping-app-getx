import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/model.dart';
import '../models/product_model.dart';

import 'details_controller.dart';

class WishlistController extends GetxController {
  final RxList<Dresses> products = <Dresses>[
  ].obs;
  RxList<WishlistItem> wishlist = <WishlistItem>[].obs;
  final detailsController = Get.put(DetailsController());
  final box = GetStorage();

  @override
  void onInit() {
    // Load saved wishlist data from Get Storage
    final savedWishlist = box.read<List<dynamic>>('isWishlistItem');

    if (savedWishlist != null) {
      // Cast the data to a list of maps and then convert it to WishlistItems
      final List<Map<String, dynamic>> savedWishlistMapList =
      List<Map<String, dynamic>>.from(savedWishlist);

      wishlist.assignAll(savedWishlistMapList
          .map((item) => WishlistItem.fromJson(item)));
    }

    // Assign the value of detailsList to products when the controller is initialized.
    products.assignAll(detailsController.detailsList);

    super.onInit();
  }
  showErrorSnackBar(var title) {
    Get.snackbar(
      animationDuration: Duration(milliseconds: 400),
      duration: Duration(milliseconds: 500),
      'Error',
      title,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  showSuccessSnackBar(var title) {
    Get.snackbar(
      animationDuration: Duration(milliseconds: 400),
      duration: Duration(milliseconds: 600),
      'Success',
      title,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }
  void addToWishlist(Dresses product) {
    if (!isInWishlist(product)) {
      wishlist.add(WishlistItem(product));
      update();
      showSuccessSnackBar(
        'Added To Wishlist',
      );
      // Save updated wishlist data to Get Storage
      box.write('isWishlistItem', wishlist.map((item) => item.toJson()).toList());
    }
  }

  void removeFromWishlist(Dresses product) {
    wishlist.removeWhere((item) => item.product == product);
    showSuccessSnackBar(
      'Removed From Wishlist' ,
    );
    // Save updated wishlist data to Get Storage
    box.remove('isWishlistItem${product.id}');
    wishlist.refresh();
  }

  bool isInWishlist(Dresses product) {


    return wishlist.any((item) => item.product == product);

  }


}
