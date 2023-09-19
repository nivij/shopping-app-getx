import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/text_controller.dart';

import '../screens/home_screen.dart';

class Customappbar extends StatefulWidget implements PreferredSizeWidget {
  const Customappbar({super.key});

  @override
  State<Customappbar> createState() => _CustomappbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(203.0);
}

class _CustomappbarState extends State<Customappbar> {
  int choice = 0;

  @override
  Widget build(BuildContext context) {

    final textController = Get.put(TextController());


    return DefaultTabController(
      
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(

            floatHeaderSlivers: true,
            physics: PageScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(

                    shadowColor: Colors.transparent,
                    toolbarHeight: 80,
                    backgroundColor: Colors.white,
                    floating: true,
                    snap: true,
                    pinned: true,
                    leading: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: CupertinoColors.black,
                          child: Icon(
                            FluentIcons.filter_12_filled,
                            color: CupertinoColors.white,
                            size: 30,
                          ),
                        )),
                    leadingWidth: 80,
                    actions: [
                      Bounceable(
                          curve: Curves.bounceOut,
                          reverseCurve: Curves.bounceIn,
                          onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => const setting(),
                            //       ));
                          },
                          child: CircleAvatar(
                            radius: 25.0,

                            backgroundImage: AssetImage('assets/profile.png',)
                          ),),
                      SizedBox(
                        width: 10,
                      )
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size(40, 60),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child:
                            ListTile(
                              leading: SizedBox(
                                height: 50,
                                width: 260,
                                child: CupertinoSearchTextField(

                                  borderRadius: BorderRadius.circular(20),
                                  itemColor: Colors.black,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white.withOpacity(0.6)),
                                  backgroundColor: Colors.black12,
                                ),
                              ),
                              trailing: CircleAvatar(
                                  backgroundColor: CupertinoColors.black,
                                  child: Icon(
                                    FluentIcons.arrow_sort_28_filled,
                                    color: Colors.white,
                                  )),
                            ),


                      ),
                    ),
                  )
                ],
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(


                    decoration: BoxDecoration(

                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(25.0)
                    ),
                    child:  TabBar(
                      labelPadding: EdgeInsets.symmetric(horizontal: 20),
                        physics: BouncingScrollPhysics(),
                      isScrollable: true,
                     labelStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),
                      indicator: BoxDecoration(

                          color: Colors.black,
                          border: Border.all(color: Colors.black),
                          borderRadius:  BorderRadius.circular(25.0)
                      ) ,
                      labelColor: Colors.white,

                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Container(
                            height:50 ,
                          width: 60,

                            child: Tab(text: 'Dresses',)),
                        Container(
                            height:30 ,
                            width: 60,
                            child: Tab(text: 'Jackets',)),
                        Container(
                            height:30 ,
                            width: 60,
                            child: Tab(text: 'Jeans',)),
                        Container(
                            height:30 ,
                            width: 60,
                            child: Tab(text: 'Shoes',))
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),

                        children:  [
                          Center(child: home(),),
                          Center(child: Text("Jackets Pages"),),
                          Center(child: Text('Jeans Page'),),
                          Center(child: Text('Shoes Page'),)
                        ],
                      )
                  )
                ],
              ),
            )
        ),

        ),
    );
    
  }
}
