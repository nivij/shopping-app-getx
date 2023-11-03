import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/screens/timeline_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/Color_controller.dart';

class OrderConfirmationScreen extends StatefulWidget {
  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final GetStorage box = GetStorage();
  List<Map<String, dynamic>> storedItems = [];

  @override
  void initState() {
    super.initState();
    loadStoredItems();
  }

  void loadStoredItems() {
    final items = box.read('cartItemsAtPayment');
    if (items != null) {
      storedItems = List<Map<String, dynamic>>.from(items);
    }
  }

  void deleteItem(int index) {
    setState(() {
      storedItems.removeAt(index);
      final items =
          storedItems.map((item) => Map<String, dynamic>.from(item)).toList();
      box.write('cartItemsAtPayment', items);
      // Update your storage or state management logic here if necessary
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorcontroller = Get.put(ColorController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('My Order',
            style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 23,
                fontWeight: FontWeight.w700)),
      ),
      body: ListView.builder(
        itemCount: storedItems.length,
        itemBuilder: (context, index) {

          final item = storedItems[index];
          final photosDynamic = item['product']?['photos'];
          final photos = photosDynamic is List ? photosDynamic.cast<String>() as List<String>? : null;
          final productNameDynamic = item['product']?['name'];
          int colorIndex = index % colorcontroller.colorlist.length;
          Color itemColor = colorcontroller.colorlist[colorIndex];
          final productName = productNameDynamic is String ? productNameDynamic as String : null;
          // Convert the int quantity to a String
          final quantity = item['quantity'].toString();
          final timestamp = item['timestamp'] != null
              ? DateTime.parse(item['timestamp'])
              : null;

          return Bounceable(
            onTap: () {
           Get.to(TimelineDemo(
                      photo: photos != null && photos.isNotEmpty ? photos[0] : 'default_photo.png',
                      name: productName ?? 'Unknown Product',
                      quantity: quantity,
                      timestamp: timestamp ?? DateTime.now(),
                      onDelete: () {
                        deleteItem(index);
                        Get.back();// Call the delete function when "Ok" is pressed
                      },
           ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.transparent,
                height: 140,
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(item['product']['photos'][0]
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['product']['name'],
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [

                              Text(
                                "Size : ",
                                style: GoogleFonts.poppins(
                                  color:Theme.of(context).colorScheme.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${item['size']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(
                                "Quantity : ",
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '$quantity',
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),


                            ],
                          ),

                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(
                                '\$${item['product']['price']}',
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Tap for more details',
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          //
          // InkWell(
          //   onTap: () => Get.to(TimelineDemo(
          //     photo: photos != null && photos.isNotEmpty ? photos[0] : 'default_photo.png',
          //     name: productName ?? 'Unknown Product',
          //     quantity: quantity,
          //     timestamp: timestamp ?? DateTime.now(),
          //     onDelete: () {
          //       deleteItem(index);
          //       Get.back();// Call the delete function when "Ok" is pressed
          //     },
          //   )),
          //   child: Dismissible(
          //     key: Key(item.toString()), // Provide a unique key for each item
          //     onDismissed: (direction) {
          //       deleteItem(index); // Call the delete function
          //     },
          //     background: Container(
          //       color: Theme.of(context).colorScheme.primary,
          //       child: Icon(Icons.delete,
          //           color: Theme.of(context).colorScheme.secondary),
          //       alignment: Alignment.centerRight,
          //       padding: EdgeInsets.only(right: 20),
          //     ),
          //     child: ListTile(
          //       leading: item['product']['photos'][0] != null
          //           ? Image.asset(item['product']['photos'][0])
          //           : SizedBox.shrink(),
          //       title: Text(
          //           'Item Name: ${item['product']['name']} - Quantity: ${item['quantity']}'),
          //       subtitle: timestamp != null
          //           ? Text('Added on: ${_formatTimestamp(timestamp)}')
          //           : Text('Timestamp not available'),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final formatter = DateFormat('yyyy-MM-dd ');
    return formatter.format(timestamp);
  }
}
