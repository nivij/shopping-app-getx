import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocart/app/controllers/SignUp_controller.dart';
import 'package:gocart/app/screens/authentication/otp/otp_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login/login_screen.dart';

class SignupPage extends StatelessWidget {
   SignupPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());


    return WillPopScope(
      onWillPop: () async {
        // Handle Android back button press
        Get.off(() => login());
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              top: 60,
              left: 16,
              right: 16,
            ),
            width: context.width,
            height: context.height,
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text("Welcome to Gocart",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.fullname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Full Name",

                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          // Add email format validation if needed
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          // Add password complexity validation if needed
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "password",
                          prefixIcon: Icon(Icons.numbers),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 16,
                      ),
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
                                SignupController.instance.registerUser(
                                    controller.email.text.trim(),
                                    controller.password.text.trim());

                              }
                            },
                            child: Text(
                              "Signup",
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            )),
                      ),

                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
