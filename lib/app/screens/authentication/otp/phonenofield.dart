import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gocart/app/consts/mediaquery.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/SignUp_controller.dart';
import 'otp_screen.dart';

class PhoneNo extends StatelessWidget {
  PhoneNo({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;
    final controller = Get.put(SignupController());
    return Scaffold(
      body:  SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Center(
            child:   Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("Send Otp",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize:  mediaQuery.instance.Title(width)),),
                  SizedBox(height: 30,),
                  Text.rich(
                    TextSpan(
                      text: "We will send you a ",
                      style: TextStyle(),
                      children: [
                        TextSpan(
                          text: "One time Password",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 70,),

                   SizedBox( width:  mediaQuery.instance.textFieldForm(width),
                      child: TextFormField(
                        controller: controller.phoneNo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone No.';
                          }
                          // Add password complexity validation if needed
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "phoneno",
                          prefixIcon: Icon(Icons.confirmation_number),
                        ),
                      ),
                    ),


                  SizedBox(height: 30,),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: mediaQuery.instance.textFieldForm(width),),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          SignupController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                          // print("-------------------");
                          // print(controller.phoneNo.text.trim());
                          Get.to(()=> OtpScreen());
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: width < 600 ? 14 : 18,
                            color: Colors.white),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
