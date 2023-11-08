import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocart/app/controllers/SignUp_controller.dart';

import 'login/login_screen.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
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
                    Text("welcome to gocart"),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.fullname,
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
    );
  }
}
