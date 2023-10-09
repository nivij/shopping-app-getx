import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';

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
    final AuthController Auth = AuthController();
    return Drawer(
      width: 200,

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(savedemail,
              style: TextStyle(
                color: Colors.white,
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
          Container(
            padding: EdgeInsets.only(),

            height: 60,
            decoration: BoxDecoration(
                color: Colors.black,
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
                    color: Colors.white,
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

