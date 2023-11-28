import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import '../respository/authentication_respositary/authentication_respository.dart';
import '../screens/chat_session/controller/chatUserList.dart';
import '../services/themedata.dart';

class Navdrawer extends StatelessWidget {
  final AuthenticationRespository controller = AuthenticationRespository.instance;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Drawer(
      width: 200,
      child: Obx(() {
        // Use Obx to observe changes in the user authentication state
        final user = controller.firebaseUser.value;

        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                user?.email ?? "Guest", // Display user email if available, else "Guest"
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('chat'),
              onTap: () {
                Get.to(()=>ChatList());
              },
            ),
            ListTile(
              leading: Icon(Icons.brightness_6),
              title: Text('Theme'),
              onTap: () {
                themeController.toggleTheme();
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
                borderRadius: BorderRadius.circular(90),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  controller.logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
