import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Gocart",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 40),),
                Text("Verification",style: Theme.of(context).textTheme.headline6,),
                SizedBox(height: 40,),
                Text("Enter the verification code sent at"+"support@gocart.com",textAlign: TextAlign.center,),
                SizedBox(height: 10*5,),
                OtpTextField(
                  numberOfFields: 6,
                 fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  filled: true,


                ),
                SizedBox(height: 30*2,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)
                      ),
                      onPressed: () {

                  }, child: Text("Next",style: GoogleFonts.poppins(color:Theme.of(context).colorScheme.secondary ),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
