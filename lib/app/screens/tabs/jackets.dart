import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:gocart/app/controllers/jacket_controller.dart';
import 'package:gocart/app/widget/dress_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/Wishlis_controller.dart';
import '../../controllers/details_controller.dart';


class jackets extends GetView<DetailsController> {

  jackets({super.key});

  @override
  Widget build(BuildContext context) {
    // final detailsController = Get.put(DetailsController());
    final JacketController jacketController = Get.put(JacketController());

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: MasonryGridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: jacketController.JacketList.length,
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context,  index ) {
          final product = jacketController.JacketList[index];

          return (index ==4)
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
