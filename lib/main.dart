import 'package:Konnect/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Konnect/screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konnect',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.lightGreen[200],
        accentColor: Colors.amber[400],
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.amber[400],
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
