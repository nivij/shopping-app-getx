import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  DatabaseReference _messagesRef = FirebaseDatabase.instance.reference().child('messages');
  List<Map<dynamic, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    // Load messages from local storage when the chat screen is initialized
    _loadMessages();

    // Start listening for incoming messages when the chat screen is initialized
    _listenForMessages();
  }

  void _listenForMessages() {
    _messagesRef.onChildAdded.listen((event) {
      Map<dynamic, dynamic> newMessage = event.snapshot.value as Map<dynamic, dynamic>;
      String messageId = newMessage['messageId'];

      // Check if the message with the same ID already exists
      if (!messages.any((message) => message['messageId'] == messageId)) {
        setState(() {
          messages.add(newMessage);
          _saveMessages();
        });
      }
    });
  }

  void _loadMessages() {
    final box = GetStorage();
    // Load messages from local storage
    List<dynamic>? messagesList = box.read('messages');
    if (messagesList != null) {
      setState(() {
        // Convert the loaded list to a list of maps
        messages = messagesList.cast<Map<dynamic, dynamic>>();
      });
    }
  }

  void _saveMessages() {
    final box = GetStorage();
    // Save messages to local storage
    box.write('messages', messages);
  }

  Widget _buildMessage(String userId, String text, String messageId) {
    return FutureBuilder<String>(
      future: _getUserEmail(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String userEmail = snapshot.data!;
          return _buildMessageWidget(userEmail, text, messageId);
        } else {
          return Container(); // or a loading indicator
        }
      },
    );
  }

  Future<String> _getUserEmail(String userId) async {
    User? user = await FirebaseAuth.instance.authStateChanges().firstWhere((user) => user != null);
    if (user != null && user.uid == userId) {
      return user.email ?? 'Unknown Email';
    } else {
      return 'Unknown Email';
    }
  }

  Widget _buildMessageWidget(String sender, String text, String messageId) {
    return GestureDetector(
      onLongPress: () {
        print("Long press detected for messageId: $messageId");
        _deleteMessage(messageId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Text(
                sender[0],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  void _deleteMessage(String messageId) {
    // Check if the message with messageId exists in the messages list
    if (messages.any((message) => message['messageId'] == messageId)) {
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
                  // Remove the message with messageId from the messages list
                  setState(() {
                    messages.removeWhere((message) => message['messageId'] == messageId);
                    _saveMessages(); // Save the updated messages list to GetStorage
                  });

                  // Remove the message from Firebase
                  _messagesRef.child(messageId).remove();

                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Delete'),
              ),
            ],
          );
        },
      );
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
            onPressed: () {
              _sendMessage();
            },
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

      // Send the message to Firebase
      String messageId = _messagesRef.push().key ?? ''; // Generate a unique message ID
      _messagesRef.child(messageId).set({
        'userId': userId,
        'message': message,
        'timestamp': ServerValue.timestamp,
        'messageId': messageId,
      });

      _messageController.clear();
    } else {
      // Handle the case when the user is not authenticated
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
                  messageSnapshot['userId'],
                  messageSnapshot['message'],
                  messageSnapshot['messageId'],
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
