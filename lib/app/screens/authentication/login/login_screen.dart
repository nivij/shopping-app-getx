import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gocart/app/screens/authentication/login/widgets/moreicons.dart';
import 'package:gocart/app/screens/authentication/otp/phonenofield.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import 'widgets/Forgetcontainer.dart';
import 'widgets/Forgotpassword.dart';

class login extends GetView<LoginController> {
  login({super.key});
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
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome to Gocart",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Additional email validation logic can be added here
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email,color: Theme.of(context).colorScheme.primary),
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
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              // Additional password validation logic can be added here
                              return null;
                            },

                        obscureText: controller.showPassword.value ? false : true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                          prefixIcon:  Icon(Icons.fingerprint,color: Theme.of(context).colorScheme.primary),
                          labelText: "password",

                          suffixIcon: IconButton(
                            icon: controller.showPassword.value
                                ?  Icon(Elusive.eye,color: Theme.of(context).colorScheme.primary)
                                :  Icon(Elusive.eye_off,color: Theme.of(context).colorScheme.primary),
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
                          child: Text("Forget?",style: GoogleFonts.montserrat(color:  Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),)),
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
                            if (controller.loginFormKey.currentState?.validate() ?? false) {
                              // Only proceed with login if form is valid
                              controller.login();
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                    ),
                    SizedBox(height: 30,),
                    Align(
                      alignment: Alignment.center,
                      child: Text.rich(TextSpan(
                        text: "Do you have a account?",
                        style: GoogleFonts.montserrat(color:  Theme.of(context).colorScheme.primary),
                        children: [
                          TextSpan(
                            text: "Signup",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),),
                    )
                   ,
                 SizedBox(height: 50,),
                    icons(
                text: 'Connect With Google',
                      onTap: () {
                       controller.isGoogleLoading.value;
                     controller.googleSignIn();

                    },
                    child:Image.asset("assets/google_icon.png",height: 40, ) , ),
                       SizedBox(height: 30,),
                    icons(
                      text: 'Connect With Phone no',
                      onTap: () {
                      Get.to(()=>PhoneNo());
                    },
                      child:Image.asset("assets/phone.png",height: 40,color: Theme.of(context).colorScheme.primary, ) , )
                  ],
                )),
          ),
        ),
      ),
    );
  }


}



