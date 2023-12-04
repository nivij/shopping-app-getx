import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gocart/app/screens/chat_session/Widget/ChatBubble.dart';
import 'package:gocart/app/screens/chat_session/controller/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage({
    Key? key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverUserID,
        _messageController.text,
      );

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail)),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessage(
        widget.receiverUserID,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return GestureDetector(
      onLongPress: () {
        if (data['senderId'] == _firebaseAuth.currentUser!.uid)
        _showDeleteDialog(document.id,_firebaseAuth.currentUser!.uid);
      },
      child: Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(data['senderEmail']),
              SizedBox(height: 7,),
              ChatBubble(message: data['message']),
              SizedBox(height: 7,),
              // Add a delete button

                // ElevatedButton(
                //   onPressed: () {
                //
                //   },
                //   child: Text('Delete'),
                // ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(String messageId, String senderId) {
    // Get the UID of the current user
    String currentUserUid = _firebaseAuth.currentUser?.uid ?? '';

    // Check if the current user is the sender of the message
    bool isSender = senderId == currentUserUid;

    // If the current user is not the sender, return without showing the dialog
    if (!isSender) {
      return;
    }

    // Show the delete dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Message'),
          content: Text('Are you sure you want to delete this message?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _chatService.deleteMessage(widget.receiverUserID, messageId);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                border: InputBorder.none,
                hintText: 'Type a message...',
              ),
            ),
          ),
          SizedBox(width: 10,),
          Bounceable(
            onTap: sendMessage,
            child: Container(
              height: 30,
              child: Image.asset("assets/message.png", color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
