import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';
import 'package:gocart/app/controllers/details_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/text_controller.dart';

import '../models/product_model.dart';
import '../screens/Search_screen.dart';
import '../screens/tabs/dresses.dart';

import 'SideNavigationDrawer.dart';

class Customappbar extends StatefulWidget implements PreferredSizeWidget {
  final Function() openDrawerCallback; // Add this callback

  Customappbar({Key? key, required this.openDrawerCallback}) : super(key: key);

  @override
  State<Customappbar> createState() => _CustomappbarState();

  @override
  Size get preferredSize => Size.fromHeight(203.0);
}

class _CustomappbarState extends State<Customappbar> {
  double minPrice = 0;
  double maxPrice = 100;
  int choice = 0;

  @override
  Widget build(BuildContext context) {
    final textController = Get.put(TextController());

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Navdrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          physics: PageScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(

              toolbarHeight: 80, // Adjust the toolbar height as needed
              shadowColor: Colors.transparent,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              floating: true,
              snap: true,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.all(14.0),
                child: InkWell(
                  onTap: () {
                    widget.openDrawerCallback();
                  },
                  child: Container(
                    width: 80,
                    height: 80, // Set the desired height
                    child: Icon(
                      FluentIcons.filter_12_filled,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              leadingWidth: 90,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0,top: 13.0,bottom: 13.0),
                  child: Bounceable(
                    curve: Curves.bounceOut,
                    reverseCurve: Curves.bounceIn,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const setting(),
                      //   ),
                      // );
                    },
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // ... other action widgets ...
              ],
              bottom: PreferredSize(

                preferredSize: Size.fromHeight(70),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ListTile(
                    leading: SizedBox(
                      height: 50,
                      width: 260,
                      child: Bounceable(
                        onTap: () {
                          Get.to(SearchScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withOpacity(0.3)),
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Elusive.search_circled,
                                color: Theme.of(context).colorScheme.primary,
                                size: 30,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Search",
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    trailing: SizedBox(
                      height: 40,
                      width: 40,
                      child: Bounceable(
                        onTap:() =>  _showPriceFilterDialog(context),
                        child: Container(
                          width: 50, // Set the desired width
                          height: 50, // Set the desired height
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: Image.asset(
                            "assets/filter.png",
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
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
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TabBar(
                    indicatorWeight: 1.0,
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    physics: BouncingScrollPhysics(),
                    isScrollable: true,
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelColor: Theme.of(context).colorScheme.secondary,
                    unselectedLabelColor: Theme.of(context).colorScheme.primary,
                    tabs: [
                      Container(
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Tab(text: 'Dresses'),
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Tab(text: 'Jackets'),
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Tab(text: 'Jeans'),
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Tab(text: 'Shoes'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      _buildProductListByCategory("Dresses"),
                      _buildProductListByCategory("Jackets"),
                      _buildProductListByCategory("Jeans"),
                      _buildProductListByCategory("Shoes"),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildProductListByCategory(String categoryId) {
    final detailsController =Get.put(DetailsController());
        List<Product> filteredProducts = detailsController.filterProductsByPriceRange(categoryId, minPrice, maxPrice);
        return Center(
          child: ProductListByCategory(
            categoryId: categoryId,
            controller: detailsController,
            // products: filteredProducts,
          ),
        );

  }

  void _showPriceFilterDialog(context) {
    double minPrice = 0;
    double maxPrice = 100;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          // Use StatefulBuilder to update the dialog's state

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Price Range Filter'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Select Price Range:'),
                RangeSlider(
                  activeColor: Theme.of(context).colorScheme.primary,
                  values: RangeValues(minPrice, maxPrice),
                  min: 0,
                  max: 2000, // Set your maximum price here
                  divisions: 100, // Adjust the number of divisions as needed
                  onChanged: (RangeValues values) {
                    setState(() {
                      minPrice = values.start;
                      maxPrice = values.end;
                    });
                  },
                ),
                Text('Min Price: ${minPrice.toStringAsFixed(2)}'), // Display prices with two decimal places
                Text('Max Price: ${maxPrice.toStringAsFixed(2)}'), // Display prices with two decimal places
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: Text('Apply'),
                onPressed: () {
                  // You should update the filtered products and refresh your UI here
                  List<Product> filteredProducts = Get.find<DetailsController>()
                      .filterProductsByPriceRange('Dresses', minPrice, maxPrice);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }

}
