import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/order_controller.dart';



class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());
    return Obx(
          () => Container(
        height: 38,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(60)),
        child: Row(
          children: [
            IconButton(
              padding: EdgeInsets.only(left: 10),
              onPressed: () {
                orderController.decrement();
              },
              icon: Icon(
                size: 20,
                Icons.remove,
                color: Colors.black,
              ),
            ),
            Text(
              '${orderController.count}',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            IconButton(
              padding: EdgeInsets.only(right: 19),
              onPressed: () {

                orderController.increment();
              },
              icon: Icon(
                size: 20,
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
