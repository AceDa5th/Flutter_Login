import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginnewver2/screens/home_screen.dart';

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
             alignment: Alignment.center,
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/images/skybackground.png"),
              fit: BoxFit.cover,
              ),
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to back to Main Page'),
            RaisedButton(
              textColor: Colors.black,
              color: Colors.blueGrey,
              child: Text('Back to Main Page'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}