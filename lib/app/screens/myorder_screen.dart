import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class OrderConfirmationScreen extends StatefulWidget {
  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
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
      final items = storedItems.map((item) => Map<String, dynamic>.from(item)).toList();
      box.write('cartItemsAtPayment', items);
      // Update your storage or state management logic here if necessary
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      body: ListView.builder(
        itemCount: storedItems.length,
        itemBuilder: (context, index) {
          final item = storedItems[index];
          final timestamp = item['timestamp'] as DateTime?;
          return Dismissible(
            key: Key(item.toString()), // Provide a unique key for each item
            onDismissed: (direction) {
              deleteItem(index); // Call the delete function
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
            ),
            child: ListTile(
              title: Text('Item Name: ${item['product']['name']}'),
              subtitle: timestamp != null
                  ? Text('Added on: ${_formatTimestamp(timestamp)}')
                  : Text('Timestamp not available'),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(timestamp);
  }
}

