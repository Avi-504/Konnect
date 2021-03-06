import 'package:flutter/material.dart';

class MessageUi extends StatelessWidget {
  final String message;
  final bool isMe;
  final key;
  final String username;
  final String userimage;
  MessageUi(this.message, this.isMe, this.username, this.userimage, {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.47,
              decoration: BoxDecoration(
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                color: isMe
                    ? Theme.of(context).accentColor
                    : Colors.deepPurple[300],
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 7,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 7,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   username,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     color: isMe ? Colors.black : Colors.white,
                  //   ),
                  // ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.black : Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -6,
          left: isMe ? MediaQuery.of(context).size.width * 0.50 : null,
          right: isMe ? null : MediaQuery.of(context).size.width * 0.50,
          child: Row(
            children: <Widget>[
              isMe
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(userimage),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: isMe ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
              SizedBox(
                width: 10,
              ),
              isMe
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: isMe ? Colors.black : Colors.white,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(userimage),
                    ),
            ],
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
