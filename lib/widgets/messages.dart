import 'package:Konnect/widgets/message_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, fsnapshot) {
        if (fsnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageUi(
                      snapshot.data.documents[index]['text'],
                      snapshot.data.documents[index]['userid'] ==
                          fsnapshot.data.uid,
                      snapshot.data.documents[index]['username'],
                      snapshot.data.documents[index]['userimage'],
                      key: ValueKey(snapshot.data.documents[index].documentID),
                    );
                  });
            });
      },
    );
  }
}
