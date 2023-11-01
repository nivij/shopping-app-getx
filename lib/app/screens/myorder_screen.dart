import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gocart/app/screens/timeline_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
          final productName = productNameDynamic is String ? productNameDynamic as String : null;
          // Convert the int quantity to a String
          final quantity = item['quantity'].toString();
          final timestamp = item['timestamp'] != null
              ? DateTime.parse(item['timestamp'])
              : null;

          return InkWell(
            onTap: () => Get.to(TimelineDemo(
              photo: photos != null && photos.isNotEmpty ? photos[0] : 'default_photo.png',
              name: productName ?? 'Unknown Product',
              qunatity: quantity,
              onDelete: () {
                deleteItem(index);
                Get.back();// Call the delete function when "Ok" is pressed
              },
            )),
            child: Dismissible(
              key: Key(item.toString()), // Provide a unique key for each item
              onDismissed: (direction) {
                deleteItem(index); // Call the delete function
              },
              background: Container(
                color: Theme.of(context).colorScheme.primary,
                child: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.secondary),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
              ),
              child: ListTile(
                leading: item['product']['photos'][0] != null
                    ? Image.asset(item['product']['photos'][0])
                    : SizedBox.shrink(),
                title: Text(
                    'Item Name: ${item['product']['name']} - Quantity: ${item['quantity']}'),
                subtitle: timestamp != null
                    ? Text('Added on: ${_formatTimestamp(timestamp)}')
                    : Text('Timestamp not available'),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final formatter = DateFormat('yyyy-MM-dd ');
    return formatter.format(timestamp);
  }
}
