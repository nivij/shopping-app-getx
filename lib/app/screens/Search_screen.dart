import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';
import 'package:gocart/app/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/Color_controller.dart';
import '../controllers/details_controller.dart';
import '../routes/app_pages.dart';

class SearchScreen extends StatelessWidget {
  final DetailsController searchController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    final colorcontroller = Get.put(ColorController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.black,
        elevation: 0, 
        leading: Icon(Icons.add,color: Colors.black,),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Container(
                  height: 90,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Bounceable(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                              ),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/left-arrow.png",
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
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
              SizedBox(height: 20),
              Obx(() {
                final searchResults = searchController.searchResults;

                if (searchResults.isEmpty) {
                  // Display a loading container while searching
                  return Center(
                    child: Container(
                      height: 120,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.withOpacity(0.3)
                      ),
                      child: Center(
                        child: Wrap(
                          children: [
                            SizedBox(width: 20,),
                            ChoiceChip(
                              label: Text("RedTape", style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w700)), // Text color
                              selected: true,
                              selectedColor:  Color(0xFFD9FFDA), // Background color when selected
                              backgroundColor:  Color(0xFFD9FFDA), // Background color when not selected
                            ),
                            SizedBox(width: 40,),
                            ChoiceChip(
                              label: Text("Highlander", style:  GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w700)), // Text color
                              selected: true,
                                selectedColor:Color(0xFFFFC8C9), // Background color when selected
                              backgroundColor: Color(0xFFFFC8C9), // Background color when not selected
                            ),
                            SizedBox(width: 10,),
                            ChoiceChip(
                              label: Text("Oversized", style:  GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w700)), // Text color
                              selected: true,
                              selectedColor: Color(0xFFFEC9F5), // Background color when selected
                              backgroundColor: Color(0xFFFEC9F5), // Background color when not selected
                            ), SizedBox(width: 20,),
                            ChoiceChip(
                              label: Text("Shirt", style:  GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w700)), // Text color
                              selected: true,
                              selectedColor:  Color(0xFFE9D4FF), // Background color when selected
                              backgroundColor: Color(0xFFFEC9F5), // Background color when not selected
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        int colorIndex = index % colorcontroller.colorlist.length;
                        Color itemColor = colorcontroller.colorlist[colorIndex];
                        final product = searchResults[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Bounceable(
                            onTap: () {
                              Get.toNamed(
                                  Routes.PRODUCTVIEW,
                                  arguments: {
                                    'index':index,
                                    'color': itemColor,
                                    'photo': product.photo,
                                    'product': product,
                                  }
                              );

                            },
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: itemColor,
                                ),
                                child: Image.asset(product.photo as String),
                              ),
                              title: Text(product.name,style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );

  }

}
