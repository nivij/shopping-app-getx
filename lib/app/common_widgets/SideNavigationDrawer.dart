import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import '../services/themedata.dart';

class Navdrawer extends StatefulWidget {
  @override
  State<Navdrawer> createState() => _NavdrawerState();
}

class _NavdrawerState extends State<Navdrawer> {
  @override
  final AuthController auth = AuthController();
  late String savedemail;
  void initState() {
    savedemail = auth.getstorage.read('email') ?? '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController()); // Initialize the theme controller

    final AuthController Auth = AuthController();
    return Drawer(
      width: 200,

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(savedemail,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle the Settings button tap
              Navigator.pop(context); // Close the drawer
            },
          ),


    ListTile(
             leading: Icon(Icons.brightness_6),
            title: Text('Theme'),
         onTap: () {
        themeController.toggleTheme(); // Use the theme controller to toggle the theme
          },
             trailing: Obx(() {

          return Switch(
           value: themeController.currentTheme.value == Darkmode,
          onChanged: (value) {

         themeController.toggleTheme();
             },
            activeColor: Theme.of(context).colorScheme.primary,
         );
      }),
    ),






          Container(
            padding: EdgeInsets.only(),

            height: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(90)
            ),
            child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                    elevation: 0,

                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent

                ),
                onPressed: () {
                  setState(() {
                    Auth.logout();
                  });

                }, child: Row(
              mainAxisAlignment:MainAxisAlignment.center ,


              children: [


                Text("logout",style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w700))
              ],
            )),
          ),
          // Add more list tiles as needed for your app
        ],
      ),
    );
  }
}

