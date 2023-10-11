import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';

import 'package:gocart/app/screens/profile_screen.dart';
import 'package:gocart/app/screens/whislist_screen.dart';
import 'package:gocart/app/widget/appbar.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import '../widget/SideNavigationDrawer.dart';
import 'Cart_screen.dart';

class base extends StatefulWidget {
  const base({super.key});

  @override
  State<base> createState() => _baseState();
}

class _baseState extends State<base> {

  int _currentIndex=0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navdrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex =index;

          });

        },
        children: [
          Customappbar(),
          CartPage(),
          WishlistPage(),
          profile()
        ],
      ),
      bottomNavigationBar: GNav(

        gap: 6.0,
        tabBackgroundColor: Colors.black,
        activeColor: Colors.white,
        tabBorderRadius:30.0,
        iconSize: 30,
        padding: EdgeInsets.all(5),
        tabMargin: EdgeInsets.all(10),
        onTabChange: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });


        } ,
        tabs: [
          GButton(icon: Elusive.home_circled,text: 'Home'),
          GButton(icon: Elusive.basket_circled,text: 'Cart'),
          GButton(icon: Elusive.heart_circled,text: 'Whislist'),
          GButton(icon: CupertinoIcons.person_circle_fill,text: 'Profile',iconSize: 34),
        ],

      ),
    );
  }
}