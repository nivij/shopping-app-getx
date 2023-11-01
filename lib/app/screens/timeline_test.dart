import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/timeline_widget.dart';

class TimelineDemo extends StatelessWidget {
  final String photo;
  final String qunatity;
  final String name;


 TimelineDemo({super.key, required this.photo, required this.qunatity, required this.name});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child:

            Column(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(color: Colors.white10,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  leading: Image.asset(photo),
                  trailing: Text(qunatity),
                  subtitle: Text(name),
                ),
              ),
            Container(
                 margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),

                decoration: BoxDecoration(color: Colors.white10,
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
                            Text("Order Placed", style: GoogleFonts.poppins(color: Colors.black))),
                    Mytimeline(
                        isFirst: false,
                        isLast: false,
                        isPast: false,
                        child:
                            Text("Shipped", style: GoogleFonts.poppins(color: Colors.black))),
                    Mytimeline(
                        isFirst: false,
                        isLast: true,
                        isPast: false,
                        child:
                            Text("Delivery", style: GoogleFonts.poppins(color: Colors.black))),
                  ],
          ),
      ),
    ),
            )
  ]

              ),
            ),
        ),
        );
  }
}
