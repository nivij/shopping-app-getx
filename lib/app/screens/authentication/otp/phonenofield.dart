import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/SignUp_controller.dart';
import 'otp_screen.dart';

class PhoneNo extends StatelessWidget {
  PhoneNo({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      body:  SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("Send Otp",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 30),),
            SizedBox(height: 30,),
            Text("We will send you a One time Password",textAlign: TextAlign.center,),
            SizedBox(height: 70,),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: controller.phoneNo,
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
              constraints:
              BoxConstraints.tightFor(width: context.width),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.black),
                    padding:
                    MaterialStateProperty.all(EdgeInsets.all(14)),
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
                    "Verify",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
