import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 60,left: 16,right: 16,),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Form(

              key: controller.authFormKey,
                child: Column(
                  children: [
                    Text("welcome to gocart"),
                    SizedBox(height: 20,),
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
                      controller: controller.emailcontroller,
                      onSaved: (value) {
                        // controller.email=value!;
                      },
                      validator: (value) {
                        return controller.validateEmail(value!);
                      },
                    ),
                    SizedBox(height: 16,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "password",
                        prefixIcon: Icon(Icons.email),


                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: controller.passwordcontroller,
                      onSaved: (value) {
                        // controller.passwordcontroller=value!;
                      },
                      validator: (value) {
                        return controller.validatePass(value!);
                      },
                    ),
                    SizedBox(height: 16,),
                    ConstrainedBox(

                        constraints:BoxConstraints.tightFor(width: context.width),
                      child: ElevatedButton(

                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black
                            ),
                            padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                          ),

                          onPressed: () {
                             controller.checklogin();
                          },

                          child: Text(
                        "Login",style: TextStyle(
                        fontSize: 14,color: Colors.white
                      ),
                      )),
                    )
                  ],
                )
            ),

          ),
        ),

      ),
    );
  }
}
