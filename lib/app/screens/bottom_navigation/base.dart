import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';

import 'package:gocart/app/screens/profile/profile_screen.dart';
import 'package:gocart/app/screens/track_order/timeline_screen.dart';
import 'package:gocart/app/screens/wishlist/wishlist_screen.dart';


import 'package:google_nav_bar/google_nav_bar.dart';


import '../../common_widgets/SideNavigationDrawer.dart';
import '../home/appbar.dart';
import '../cart/Cart_screen.dart';
import '../myorder/myorder_screen.dart';

class base extends StatefulWidget {

  const base({super.key, });

  @override
  State<base> createState() => _baseState();
}

class _baseState extends State<base> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          // If on the Customappbar page, open the drawer or handle custom logic
          _scaffoldKey.currentState?.openDrawer();
          return false;
        } else {
          // If on another page, navigate back to the Customappbar page
          _pageController.jumpToPage(0);
          return false;
        }
      },
      child: Scaffold(
        key: _scaffoldKey, // Assign the scaffold key here
        drawer: Navdrawer(),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex =index;

            });

          },
          children: [
            Customappbar(openDrawerCallback: () {  _scaffoldKey.currentState?.openDrawer(); },),
            CartPage(),
            WishlistPage(),
            OrderConfirmationScreen()
          ],
        ),
        bottomNavigationBar: GNav(

         backgroundColor: Theme.of(context).colorScheme.secondary,
          gap: 6.0,
          tabBackgroundColor: Theme.of(context).colorScheme.onBackground,
          activeColor: Colors.white,
          tabBorderRadius:30.0,
          iconSize: 30,

          padding: EdgeInsets.all(5),
          tabMargin: EdgeInsets.all(10),
          onTabChange: (index) {
            setState(() {
              _pageController.jumpToPage(index);
              _currentIndex = index;
            });


          } ,


          tabs: [
            GButton(icon: Elusive.home_circled,text: 'Home'),
            GButton(icon: Elusive.basket_circled,text: 'Cart'),
            GButton(icon: Elusive.heart_circled,text: 'Whislist'),
            GButton(icon: Elusive.calendar_circled,text: 'Orders',),
          ],
          selectedIndex: _currentIndex,
        ),
      ),
    );
  }
}