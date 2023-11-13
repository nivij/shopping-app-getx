import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import 'widgets/Forgetcontainer.dart';
import 'widgets/Forgotpassword.dart';

class login extends GetView<LoginController> {
  login({super.key});
  final loginFormKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
                key: loginFormKey,
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
                      controller: controller.email,

                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                          () => TextFormField(

                        controller: controller.password,
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter your password';
                          return null;
                        },

                        obscureText: controller.showPassword.value ? false : true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(Icons.fingerprint),
                          labelText: "password",

                          suffixIcon: IconButton(
                            icon: controller.showPassword.value
                                ? const Icon(Elusive.eye)
                                : const Icon(Elusive.eye_off),
                            onPressed: () => controller.showPassword.value = !controller.showPassword.value,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // TextFormField(
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     labelText: "phone no",
                    //     prefixIcon: Icon(Icons.email),
                    //   ),
                    //   keyboardType: TextInputType.visiblePassword,
                    //   obscureText: true,
                    //   controller: controller.passwordcontroller,
                    //   onSaved: (value) {
                    //     // controller.passwordcontroller=value!;
                    //   },
                    //   validator: (value) {
                    //     return controller.validatePass(value!);
                    //   },
                    // ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            ForgotPassword.buildShowModalBottomSheet(context);
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
                            controller.login();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.SIGNUP);
                          },
                          child: Text("Do you have a account? Signup")),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }


}



