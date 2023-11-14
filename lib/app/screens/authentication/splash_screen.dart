import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gocart/app/controllers/splash_controller.dart';

class Splash extends StatelessWidget{
   Splash({Key? key}) : super(key:key);
final SplashController splashController =SplashController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Image.asset("assets/cartSplash.gif",color: Colors.white),
      ),
    );
  }
}
