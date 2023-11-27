import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as messaging;
import 'package:http/http.dart' as http;
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference().child('messages');
  List<Map<dynamic, dynamic>> messages = [];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _configureFirebaseMessaging();
    _loadMessages();
    _listenForMessages();

  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onResume: $message");
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void _listenForMessages() {
    _messagesRef.onChildAdded.listen((event) {
      if (mounted) {
        Map<dynamic, dynamic> newMessage =
        event.snapshot.value as Map<dynamic, dynamic>;
        String messageId = newMessage['messageId'];

        if (!messages.any((message) => message['messageId'] == messageId)) {
          _getUserEmail(newMessage['userId']).then((userEmail) {
            newMessage['userEmail'] = userEmail;
            setState(() {
              messages.add(newMessage);
              _saveMessages();
            });
          });
        }
      }
    });

    _messagesRef.onChildRemoved.listen((event) {
      if (mounted) {
        String deletedMessageId = event.snapshot.key ?? '';
        setState(() {
          messages.removeWhere(
                  (message) => message['messageId'] == deletedMessageId);
          _saveMessages();
        });
      }
    });
  }

  Future<String> _getUserEmail(String userId) async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null && user.uid == userId) {
      return user.email ?? '';
    } else {
      // Fetch user details from Firestore or your user database
      // and return the user's email
      // For demonstration purposes, assuming the user's email is stored in Firebase Realtime Database
      DataSnapshot snapshot = (await FirebaseDatabase.instance
          .reference()
          .child('users/$userId')
          .once())
          .snapshot;
      Map<dynamic, dynamic>? userData =
      snapshot.value as Map<dynamic, dynamic>?;

      return userData?['email'] ?? '';
    }
  }

  void _loadMessages() {
    final box = GetStorage();
    List<dynamic>? messagesList = box.read('messages');
    if (messagesList != null) {
      setState(() {
        messages = messagesList.cast<Map<dynamic, dynamic>>();
      });
    }
  }

  void _saveMessages() {
    final box = GetStorage();
    box.write('messages', messages);
  }

  Future<void> _sendFCMMessage(String message, String userId) async {
    List<String> otherUserTokens = [];
    for (var otherUser in messages.where((m) => m['userId'] != userId)) {
      String otherUserId = otherUser['userId'];
      String? token = await _getFCMToken(otherUserId);
      if (token != null) {
        otherUserTokens.add(token);
      }
    }

    if (otherUserTokens.isNotEmpty) {
      for (var token in otherUserTokens) {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=AAAAulIBZuI:APA91bH7yJJlpt7470K9XV2cbU9wCH7OUTpSR7lzqlfkcVs9WN8GLDXRLYfpmi_zEhAm6fvrBre1IHnY5JKrhTWS_PFE1MMc_5ExZArJuFElymc-Y71KmOUn8hgrQwqw_MyuayEzQOp6', // Replace with your server key
          },
          body: jsonEncode({
            'to': token,
            'data': {
              'userId': userId,
              'messageId': messages.last['messageId'],
            },
            'notification': {
              'title': 'New Message',
              'body': message,
            },
          }),
        );
      }
    }
  }


  Future<String?> _getFCMToken(String userId) async {
    DataSnapshot snapshot = (await FirebaseDatabase.instance
        .reference()
        .child('users/$userId')
        .once()).snapshot;
    Map<dynamic, dynamic>? userData = snapshot.value as Map<dynamic, dynamic>?;

    return userData?['fcmToken'];

  }

  Widget _buildMessage(String userId, String text, String messageId,int index) {
    var message = messages[index];
    var userEmail = message['userEmail'] ?? 'Unknown User';
    print("$userEmail-usermaillllllllllllllllllllllllllllllllllll");
    return GestureDetector(
      onLongPress: () {
        _showDeleteMessageDialog(messageId);
      },
      child: Container(
        alignment: userId == FirebaseAuth.instance.currentUser?.email
            ? Alignment.centerRight
            : Alignment.centerLeft,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: userId == FirebaseAuth.instance.currentUser?.email
                ? Colors.blue
                : Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                'Sent by: $userEmail',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showDeleteMessageDialog(String messageId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Message?'),
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
                _deleteMessage(messageId);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteMessage(String messageId) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      // Check if the current user is the sender of the message
      if (messages.any((message) => message['messageId'] == messageId && message['userId'] == userId)) {
        // Delete the message from the local list
        setState(() {
          messages.removeWhere((message) => message['messageId'] == messageId);
          _saveMessages(); // Save the updated list to storage
        });

        // Delete the message from the Firebase Realtime Database
        _messagesRef.child(messageId).remove().then((_) {
          print('Message deleted from the server.');
        }).catchError((error) {
          print('Error deleting message from the server: $error');
        });
      } else {
        print('You can only delete your own messages.');
      }
    } else {
      print('User not authenticated');
    }
  }




  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;
      String message = _messageController.text;

      String messageId = _messagesRef.push().key ?? '';
      _messagesRef.child(messageId).set({
        'userId': userId,
        'message': message,
        'timestamp': ServerValue.timestamp,
        'messageId': messageId,
      });

      _sendFCMMessage(message, userId);

      _messageController.clear();
    } else {
      print('User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Support'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var messageSnapshot = messages[index];

                return _buildMessage(
                  messageSnapshot['userEmail'],
                  messageSnapshot['message'],
                  messageSnapshot['messageId'],
                  index,
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }
}
