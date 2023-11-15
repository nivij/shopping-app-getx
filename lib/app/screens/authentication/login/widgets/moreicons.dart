import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class icons extends StatelessWidget {
  const icons({
    super.key,  required this.onTap, this.child, required this.text,
    // required this.text,
  });
  final  child;
  final String text;
  // final Text text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Theme.of(context).colorScheme.primary)
          ),
          height: 50,


          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold)),
            SizedBox(width: 10,),
            child
            ],
          )
        ) );
  }
}

