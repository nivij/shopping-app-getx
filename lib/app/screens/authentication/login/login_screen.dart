import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gocart/app/consts/mediaquery.dart';
import 'package:gocart/app/screens/authentication/login/widgets/moreicons.dart';
import 'package:gocart/app/screens/authentication/otp/phonenofield.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../Signup_screen.dart';
import 'widgets/Forgetcontainer.dart';
import 'widgets/Forgotpassword.dart';

class login extends StatelessWidget {
  login({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to Gocart",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.instance.Title(width),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width:mediaQuery.instance.textFieldForm(width),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.email,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(
                        () => SizedBox(width: mediaQuery.instance.textFieldForm(width),
                          child: TextFormField(
                      controller: controller.password,
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                      },
                      obscureText:
                      controller.showPassword.value ? false : true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.fingerprint,
                              color: Theme.of(context).colorScheme.primary),
                          labelText: "password",
                          suffixIcon: IconButton(
                            icon: controller.showPassword.value
                                ? Icon(Elusive.eye,
                                color:
                                Theme.of(context).colorScheme.primary)
                                : Icon(Elusive.eye_off,
                                color:
                                Theme.of(context).colorScheme.primary),
                            onPressed: () =>
                            controller.showPassword.value =
                            !controller.showPassword.value,
                          ),
                      ),
                    ),
                        ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(width: mediaQuery.instance.textFieldForm(width),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ForgotPassword.buildShowModalBottomSheet(context);
                        },
                        child: Text(
                          "Forget?",
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
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
                        if (controller.loginFormKey.currentState?.validate() ?? false) {
                          // Form validation passed, call the login function
                          print("Validation passed. Attempting login...");
                          controller.login();
                        } else {
                          print("Validation failed. Please check your input.");
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
                  SizedBox(
                    height: 30,
                  ),
                  Bounceable(
                    onTap: () {
                      Get.offAllNamed(Routes.SIGNUP);

                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          text: "Do you have an account?",
                          style: GoogleFonts.montserrat(
                              color:
                              Theme.of(context).colorScheme.primary),
                          children: [
                            TextSpan(
                              text: "Signup",
                              style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  icons(
                    text: 'Connect With Google',
                    onTap: () {
                      controller.isGoogleLoading.value;
                      controller.googleSignIn();
                    },
                    child: Image.asset(
                      "assets/google_icon.png",
                      height: 40,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  icons(
                    text: 'Connect With Phone no',
                    onTap: () {
                      Get.to(() => PhoneNo());
                    },
                    child: Image.asset(
                      "assets/phone.png",
                      height: 40,
                      color: Theme.of(context).colorScheme.primary,
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
