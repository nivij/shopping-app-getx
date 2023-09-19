import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/details_controller.dart';

class BasicDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final detailsController = Get.put(DetailsController());

    return Scaffold(
      appBar: AppBar(title: Text('Basic demo')),
      body: Container(
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,

              autoPlayInterval: Duration(seconds: 1)
            ),
            items: detailsController.detailsList
                .map((item) => Container(
              child: Center(child: Text(item.toString())),
              color: Colors.green,
            ))
                .toList(),
          )),
    );
  }
}