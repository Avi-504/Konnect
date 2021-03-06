import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/dev.jpg'),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'This App is Created and Maintained by Avi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('To report any bugs or to give suggestions'),
                  Text(
                    'Contact @ talksgeeky@gmail.com',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
