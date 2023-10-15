import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gocart/app/controllers/details_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/Wishlist_controller.dart';
import '../controllers/text_controller.dart';

import '../models/product_model.dart';
import '../screens/Search_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/tabs/dresses.dart';

import 'SideNavigationDrawer.dart';

class Customappbar extends StatefulWidget implements PreferredSizeWidget {
  final Function() openDrawerCallback; // Add this callback

  Customappbar({Key? key, required this.openDrawerCallback}) : super(key: key);
  @override
  State<Customappbar> createState() => _CustomappbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(203.0);
}

class _CustomappbarState extends State<Customappbar> {
  int choice = 0;

  @override
  Widget build(BuildContext context) {

    final textController = Get.put(TextController());

    // final WishlistController wishlistController = Get.put(WishlistController());
    return DefaultTabController(

      length: 4,
      child: Scaffold(
         drawer: Navdrawer(),

        backgroundColor: Colors.white,
        body: NestedScrollView(

            floatHeaderSlivers: true,
            physics: PageScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(

                    shadowColor: Colors.transparent,
                    toolbarHeight: 80,
                    backgroundColor: Colors.white,
                    floating: true,
                    snap: true,
                    pinned: true,
                    leading: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: InkWell(
                          onTap: () {
                            widget.openDrawerCallback();

                          },
                          child: CircleAvatar(

                            radius: 10,
                            backgroundColor: CupertinoColors.black,
                            child: Icon(

                              FluentIcons.filter_12_filled,
                              color: CupertinoColors.white,
                              size: 30,
                            ),
                          ),
                        )),
                    leadingWidth: 80,
                    actions: [
                      Bounceable(
                          curve: Curves.bounceOut,
                          reverseCurve: Curves.bounceIn,
                          onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => const setting(),
                            //       ));
                          },
                          child: CircleAvatar(
                            radius: 25.0,

                            backgroundImage: AssetImage('assets/profile.png',)
                          ),),
                      SizedBox(
                        width: 10,
                      )
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size(40, 56),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child:
                            ListTile(
                              leading: SizedBox(
                                height: 50,
                                width: 260,
                                child: Bounceable(
                                  onTap: () {
                                    Get.to(SearchScreen());
                                  },
                                  child: Container(

                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                                      color: Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10,),
                                        Icon(Elusive.search_circled,color: Colors.black,size: 30,),
                                        SizedBox(width: 20,),
                                        Text("Search",style: GoogleFonts.poppins(color: Colors.black,fontSize: 16),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              trailing:  SizedBox(
                                height: 40,
                                width: 40,
                                child: Bounceable(

                             onTap:  _showPriceFilterDialog,

                                    child: Container(
                                      width: 50, // Set the desired width
                                      height: 50, // Set the desired height

                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(90),
                                      ),
                                      child: Image.asset(
                                        "assets/filter.png",
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),


                      ),
                    ),
                  )
                ],
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 6,),
                  Container(


                    decoration: BoxDecoration(

                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(25.0)
                    ),
                    child:  TabBar(
                      labelPadding: EdgeInsets.symmetric(horizontal: 17),
                        physics: BouncingScrollPhysics(),
                      isScrollable: true,
                     labelStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),
                      indicator: BoxDecoration(

                          color: Colors.black,
                          border: Border.all(color: Colors.black),
                          borderRadius:  BorderRadius.circular(25.0)
                      ) ,
                      labelColor: Colors.white,

                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Container(
                            height:50 ,
                          width: 60,

                            child: Tab(text: 'Dresses',)),
                        Container(
                            height:30 ,
                            width: 60,
                            child: Tab(text: 'Jackets',)),
                        Container(
                            height:30 ,
                            width: 60,
                            child: Tab(text: 'Jeans',)),
                        Container(
                            height:30 ,
                            width: 60,
                            child: Tab(text: 'Shoes',))
                      ],
                    ),
                  ),
                  // for(var i=0;i<wishlistController.products.length;i++)
                  Expanded(
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),

                        children:  [


                          // Center(child: jackets(),),
                          Center(child: ProductListByCategory(categoryId: "Dresses",controller: DetailsController(),)),
                          Center(child: ProductListByCategory(categoryId: "Jackets",controller: DetailsController(),)),
                          Center(child: ProductListByCategory(categoryId: "Jeans",controller: DetailsController(),)),
                          Center(child: ProductListByCategory(categoryId: "Shoes",controller: DetailsController(),)),


                        ],
                      )
                  )
                ],
              ),
            )
        ),

        ),
    );

  }
  // Inside your widget where you want to display the filter icon and the dialog:
  void _showPriceFilterDialog() {
    double minPrice = 0;
    double maxPrice = 100; // You can set the initial price range here.

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Price Range Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Select Price Range:'),
              RangeSlider(
                activeColor: Colors.black,
                values: RangeValues(minPrice , maxPrice ),
                min: 0,
                max: 100, // Set the maximum price as needed.
                onChanged: (RangeValues values) {
                  setState(() {
                    minPrice = values.start;
                    maxPrice = values.end ;
                  });
                },
              ),
              Text('Min Price: $minPrice'),
              Text('Max Price: $maxPrice'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: Text('Apply'),
              onPressed: () {
                List<Product> filteredProducts = Get.find<DetailsController>()
                    .filterProductsByPriceRange('Dresses', minPrice, maxPrice);
                // Do something with the filtered products, e.g., update the UI.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
