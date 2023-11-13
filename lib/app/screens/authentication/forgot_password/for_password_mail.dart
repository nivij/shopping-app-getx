import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../otp/otp_screen.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             Text("Forget Password",style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.primary,fontSize: 20)),
             SizedBox(height: 10,),
             Text("Select one of the options given below to reset your passwords",textAlign: TextAlign.center,style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.primary,fontSize: 15,)),

             SizedBox(height: 30*2,),
             TextFormField(
               autovalidateMode: AutovalidateMode.onUserInteraction,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                 ),
                 labelText: "Email",
                 prefixIcon: Icon(Icons.email),
               ),
               keyboardType: TextInputType.emailAddress,


             ),
             SizedBox(height: 10*5,),
             ConstrainedBox(
               constraints:
               BoxConstraints.tightFor(width: context.width),
               child: ElevatedButton(
                   style: ButtonStyle(
                     shape: MaterialStateProperty.all(
                         RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20),
                         )),
                     backgroundColor:
                     MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                     padding:
                     MaterialStateProperty.all(EdgeInsets.all(14)),
                   ),
                   onPressed: () {
                    Get.to(()=>OtpScreen());
                   },
                   child: Text(
                     "Next",
                     style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary),
                   )),
             ),
           ],
         ),
        ),
      ),
    );
  }
}
