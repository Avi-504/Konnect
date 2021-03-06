import 'package:Konnect/screens/about.dart';
import 'package:Konnect/widgets/messages.dart';
import 'package:Konnect/widgets/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (message) {
        print(message);
        return;
      },
      onLaunch: (message) {
        print(message);
        return;
      },
      onResume: (message) {
        print(message);
        return;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konnect'),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 7,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.info),
                      SizedBox(
                        width: 7,
                      ),
                      Text('About'),
                    ],
                  ),
                ),
                value: 'about',
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
              if (value == 'about') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => About(),
                  ),
                );
              }
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
