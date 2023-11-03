import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../widget/timeline_widget.dart';


const LatLng currentLocation = LatLng(25.1193,55.3773);


class TimelineDemo extends StatefulWidget {
  final String photo;
  final String quantity;
  final String name;
  final Function() onDelete;
  final DateTime? timestamp;

  TimelineDemo(
      {super.key,
      required this.photo,
      required this.quantity,
      required this.name,
      required this.onDelete, this.timestamp});

  @override
  State<TimelineDemo> createState() => _TimelineDemoState();
}

class _TimelineDemoState extends State<TimelineDemo> {
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
          centerTitle: true,
          title: Text('Track Order',
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 23,
                  fontWeight: FontWeight.w700)),
        ),
        body: Stack(
          children: [
            SizedBox(height: 500,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.7749, -122.4194), // Initial map location
                  zoom: 14.0, // Zoom level
                ),
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
              ),
            ),
            DraggableScrollableSheet(
              snap: true,
                builder: (BuildContext context, scrollController) {
                  return Container(

                    decoration:BoxDecoration(
                      border: Border.all(

                        color: Theme.of(context).colorScheme.primary
                      ),
                        color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ListTile(
                              leading: Text('Added On : ${widget.timestamp != null ? DateFormat('yyyy-MM-dd').format(widget.timestamp!) : "N/A"}',
                              style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.primary),
                              ),
                              trailing:  ElevatedButton(
                                style: ButtonStyle(

                                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.inversePrimary)
                                ),
                                onPressed: () {
                                  _showPriceFilterDialog(context);
                                },
                                child: Text("Cancel Order",
                                    style: GoogleFonts.poppins(
                                        color:
                                        Theme.of(context).colorScheme.secondary)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: Image.asset(widget.photo),
                                trailing: Text('Quantity :  ${widget.quantity}',
                                    style: GoogleFonts.poppins(
                                        color:
                                        Theme.of(context).colorScheme.secondary)),
                                title: Text(widget.name,
                                    style: GoogleFonts.poppins(
                                        color:
                                        Theme.of(context).colorScheme.secondary)),
                              ),
                            ),
                            Container(
                              margin:
                              EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                child: SizedBox(
                                  height: 450,
                                  child: ListView(
                                    children: [
                                      Mytimeline(
                                          isFirst: true,
                                          isLast: false,
                                          isPast: true,
                                          child: Text("Order Placed",
                                              style: GoogleFonts.poppins(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary))),
                                      Mytimeline(
                                          isFirst: false,
                                          isLast: false,
                                          isPast: false,
                                          child: Text("Shipped",
                                              style: GoogleFonts.poppins(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary))),
                                      Mytimeline(
                                          isFirst: false,
                                          isLast: true,
                                          isPast: false,
                                          child: Text("Delivery",
                                              style: GoogleFonts.poppins(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary))),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ]),
                    ),
                  );
                }),

          ] )
    );
  }

  void _showPriceFilterDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          // Use StatefulBuilder to update the dialog's state

          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Cancel Your Order'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Are You Sure'),
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
                child: Text('Ok'),
                onPressed: () {
                  widget.onDelete(); // Call the onDelete callback
                  Get.back();
                },
              ),
            ],
          );
        });
      },
    );
  }
}
