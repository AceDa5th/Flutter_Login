import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginnewver2/screens/2nd_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
enum WhyFarther { Signout, Next_Page }
class _HomeScreenState extends State<HomeScreen> {
  @override

  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
    backgroundColor: Colors.blueGrey,
    toolbarHeight: 60.0,
      ),

    body: Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/skybackground.png"),
    fit: BoxFit.cover,
    )
    ),
    ),
    bottomNavigationBar: BottomAppBar(
    color: Colors.blueGrey,
    shape: CircularNotchedRectangle(),
    child: Container(
        height: 70.0,
    child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
    PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                     navigateToSubPage(context);
                    },
                ),
                  ),
              PopupMenuItem(
                value: 2,
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                  FirebaseAuth.instance.signOut();
                  }
                ),
              ),
            ]
          ),
      ],
    )
    )
    )
    );
  }
}
