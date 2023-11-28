

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gocart/app/screens/chat_session/chat_screen.dart';


class ChatList extends StatelessWidget {
  // final ChatController chatController = Get.put(ChatController());
  final FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body:_buildUserList(),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder:(context, snapshot) {
        if(snapshot.hasError){
          return const Text('error');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('loading....');
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }
  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String,dynamic> data =document.data()! as Map<String,dynamic>;
   if(_auth.currentUser!.email !=data ['email']){
     return ListTile(
       title: Text(data['email']),
       onTap:  () {
         Get.to(ChatPage(
           receiverUserEmail: data['email'],
           receiverUserID: data['uid'],));
       },
     );
   }else{
     return Container();
   }
  }
}

