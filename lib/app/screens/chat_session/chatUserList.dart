import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocart/app/screens/chat_session/controller/chat_screen.dart';

class ChatList extends StatefulWidget {
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Support'),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // print("Error: ${snapshot.error}");
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          // print("Loading...");
          return Text('Loading....');
        }

        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    // print("Document: $document");
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('email') && _auth.currentUser != null && _auth.currentUser!.email != data['email']) {
      // print("Email: ${data['email']}, UID: ${data['uid']}");
      return ListTile(
        title: Text(data['email'] ?? "Email not found"),
        onTap: () {
          // print("Tapped on email: ${data['email']}");
          Get.to(() => ChatPage(
            receiverUserEmail: data['email'],
            receiverUserID: data['uid'],
          ));
        },
      );
    } else {
      return Container();
    }

  }
}
