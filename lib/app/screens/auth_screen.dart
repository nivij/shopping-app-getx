import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widget/Forgetcontainer.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
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
                key: controller.authFormKey,
                child: Column(
                  children: [
                    Text("welcome to gocart"),
                    SizedBox(
                      height: 20,
                    ),
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
                    SizedBox(
                      height: 16,
                    ),
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
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "phone no",
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              context: context,
                              builder: (context) => Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Make Selection!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(fontSize: 30),
                                    ),
                                    Text(
                                      "Select one of the options given below to reset your password",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    forgotscontainer(
                                      onTap: () {

                                      },
                                        title: "E-mail",
                                        subtitle:
                                            "Reset via E-mail Verification",
                                        Iconn: Icons.email_outlined),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    forgotscontainer(
                                      onTap: () {

                                      },
                                      title: "Phone no",
                                      subtitle:
                                          "Reset via Phone no Verfication",
                                      Iconn: Icons.phone_android_outlined,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text("Forget?")),
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
                            //check login in auth_controlller
                            controller.checklogin();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}



