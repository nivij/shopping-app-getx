import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/order_controller.dart';
import '../models/product_model.dart';



class Counter extends StatefulWidget {
  final OrderController orderController;
  final Product product;

  Counter({required this.orderController, required this.product});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: 38,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.only(left: 10),
            onPressed: () {

              widget.orderController.decrement();
              // widget.orderController.updateCartItemQuantityByIndex(widget.product, widget.orderController.count.value,); // Pass the size here
            },
            icon: Icon(
              Icons.remove,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            '${widget.orderController.count.value}',
            style: GoogleFonts.poppins(fontSize: 18),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 19),
            onPressed: () {

              // widget.orderController.updateCartItemQuantityByIndex( widget.orderController.count.value + 1, index ); // Pass the size here
              widget.orderController.increment();
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    ));
  }
}
