import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:funchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funchat/screens/welcome_screen.dart';

class ChatScreen extends StatefulWidget {
  //id for route
  static const String id = 'ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (error) {
      print(error);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void messagesStream() async {
    //think of streams as a List
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text(
          'FunChat',
          style: TextStyle(
              color: appPink,
              fontSize: 35,
              fontWeight: FontWeight.w900,
              shadows: [
                Shadow(
                  // bottomLeft
                  offset: Offset(-1.5, -1.5),
                  color: Colors.white,
                  blurRadius: 5,
                ),
                Shadow(
                  // bottomRight
                  offset: Offset(1.5, -1.5),
                  color: Colors.white,
                  blurRadius: 5,
                ),
                Shadow(
                  // topRight
                  offset: Offset(1.5, 1.5),
                  color: Colors.white,
                  blurRadius: 5,
                ),
                Shadow(
                  // topLeft
                  offset: Offset(-1.5, 1.5),
                  color: Colors.white,
                  blurRadius: 5,
                ),
              ]),
        ),
        backgroundColor: appBlue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("messages").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Text> messageWidgets = [];
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: appBlue,
                    ),
                  );
                }
                final messages = snapshot.data.docs;
                for (var message in messages) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['sender'];
                  final messageWidget =
                      Text('$messageText from $messageSender');
                  messageWidgets.add(messageWidget);
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: messageWidgets,
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      //path has to be same name as collection name
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
