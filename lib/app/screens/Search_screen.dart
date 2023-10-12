import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';
import 'package:gocart/app/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/Color_controller.dart';
import '../controllers/details_controller.dart';

// Import your search controller

class SearchScreen extends StatelessWidget {
  final DetailsController searchController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    final colorcontroller = Get.put(ColorController());

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.black
                ,borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft:Radius.circular(50) ),
                ),
                child: Container(
                  height: 90,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Bounceable(onTap: () => Get.back(),
                          child: Container(
                              width: 40, // Set the desired width
                              height: 40, // Set the desired height
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(

                                  color: Colors.white.withOpacity(0.4)
                                ),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset(

                                "assets/left-arrow.png",
                                color: Colors.white,
                              )),),
                        SizedBox(width: 10), // Add some spacing between the icon and search field
                        Expanded(
                          child: CupertinoSearchTextField(
                            prefixIcon: Icon(Elusive.search_circled),

                            itemColor: Colors.white,
                            style: GoogleFonts.poppins(color: Colors.white),
                            autofocus: true,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            onSubmitted: (query) {
                              searchController.searchProducts(query);
                            },
                            onChanged: (query) {
                              if (query.isEmpty) {
                                searchController.clearSearchResults();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            SizedBox(height: 20,),
              Obx(() {
                final searchResults = searchController.searchResults;
                return  Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      int colorIndex = index % colorcontroller.colorlist.length; // Use modulo to cycle through colors
                      Color itemColor = colorcontroller.colorlist[colorIndex];
                      final product = searchResults[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Bounceable(
                          onTap:() {
                            Get.to(ProductScreen(
                                index: index,
                                colors: itemColor,
                                photo: product.photo,
                                product: product
                            ));

                          },
                          child: ListTile(
                            leading: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: itemColor,
                              ),
                              child: Image.asset(product.photo),
                            ),
                            title: Text(product.name),
                            // Display other product information here
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
