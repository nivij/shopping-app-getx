import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gocart/app/controllers/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final AuthController auth = AuthController();
  late String savedemail;
  @override
  void initState() {
    savedemail = auth.getstorage.read('email') ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final AuthController Auth= AuthController();
    return Scaffold(
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: Text(savedemail)),
          Container(
            padding: EdgeInsets.only(),
            width: 180,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40)
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
        ],
      ),
    );
  }
}
