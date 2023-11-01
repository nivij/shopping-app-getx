import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/timeline_widget.dart';

class TimelineDemo extends StatelessWidget {
  final String photo;
  final String qunatity;
  final String name;
  final Function() onDelete;

 TimelineDemo({super.key, required this.photo, required this.qunatity, required this.name, required this.onDelete});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Order Details',
            style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 23,
                fontWeight: FontWeight.w700)),
      ),
        body: SafeArea(
          child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child:

            Column(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  leading: Image.asset(photo),
                  trailing: Text(qunatity,style: GoogleFonts.poppins(color:Theme.of(context).colorScheme.secondary )),
                  subtitle: Text(name,style: GoogleFonts.poppins(color:Theme.of(context).colorScheme.secondary )),
                ),
              ),
            Container(
                 margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),

                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SizedBox(height: 500,
          child: ListView(

                padding: EdgeInsets.symmetric(vertical: 10),

                  children: [
                    Mytimeline(
                        isFirst: true,
                        isLast: false,
                        isPast: true,
                        child:
                            Text("Order Placed", style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.primary))),
                    Mytimeline(
                        isFirst: false,
                        isLast: false,
                        isPast: false,
                        child:
                            Text("Shipped", style: GoogleFonts.poppins(color:  Theme.of(context).colorScheme.primary))),
                    Mytimeline(
                        isFirst: false,
                        isLast: true,
                        isPast: false,
                        child:
                            Text("Delivery", style: GoogleFonts.poppins(color:  Theme.of(context).colorScheme.primary))),
                  ],
          ),
      ),
    ),
            ),
                  Container(
                    padding: EdgeInsets.only(),
                    width: 140,
                    height: 32,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: ElevatedButton(onPressed: () {
                      _showPriceFilterDialog(context);
                    }, child: Text("Cancel Order",style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.secondary)), )
                  ),
  ]

              ),
            ),
        ),
        );
  }
  void _showPriceFilterDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          // Use StatefulBuilder to update the dialog's state

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  onDelete(); // Call the onDelete callback
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
