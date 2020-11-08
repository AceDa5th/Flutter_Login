import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginnewver2/screens/2nd_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
enum WhyFarther { Signout, Next_Page }
class _HomeScreenState extends State<HomeScreen> {
  final db = FirebaseFirestore.instance;
  String todoTitle = "";
  @override


  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  }
  createTodos(){
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(todoTitle);
    Map<String, String> todos = {
      "todoTitle" : todoTitle
    };

    documentReference.set(todos).whenComplete(() {
      print("$todoTitle created");
    }
    );
  }
  editTodos(item){
    //EDIT WONT WORK, SO DONT USE IT... I TRIED FOR 2HOURS TO GET IT TO WORK BUT ME HAVE NO CLUE HOW TO.
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(item);
    Map<String, String> todos = {
      "todoTitle" : todoTitle
    };
    documentReference.update(todos).whenComplete(() {
      print("edited");
    }
    );
  }
  deleteTodos(todoTitle){
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(todoTitle);
    documentReference.delete().whenComplete((){
      print("delete");
    }
    );
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
      child: StreamBuilder(stream: FirebaseFirestore.instance.collection("MyTodos").snapshots(), builder: (context,
          snapshots){
        return ListView.builder(
        itemCount: snapshots.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot documentSnapshot = snapshots.data.documents[index];
          return Dismissible(
            onDismissed: (direction) {
              deleteTodos(documentSnapshot["todoTitle"]);
            },
            key: Key(documentSnapshot["todoTitle"]),
            child: Card(
              color: Colors.white60,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                title: Text(documentSnapshot["todoTitle"]),
                trailing: IconButton(
                  icon: Icon(
                      Icons.delete,
                      color: Colors.red
                  ),
                  onPressed: () {
                    deleteTodos(documentSnapshot["todoTitle"]);
                  },
                ),
              ),
            ),
          );
        });
    },
    ),
    ),
    bottomNavigationBar: BottomAppBar(
    color: Colors.blueGrey,
    child: Container(
        height: 100.0,
    child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              iconSize: 30.0,
              padding: EdgeInsets.only(left: 0),
              icon: Icon(Icons.add_circle),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white38,
                      title: Text("Add to list"),
                      content: TextField(
                        onChanged: (String value){
                          todoTitle = value;
                        }
                      ),
                        actions: <Widget>[
                          FlatButton(
                        onPressed: ()
                    {
                      createTodos();
                      Navigator.of(context).pop();
                    },
                             child: Icon(
                    Icons.add,
                    )
                          )]
                    );
                  }
                );
              }
          ),
          ]),
    Row(
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
    ]
                )
      ],
    )
    )
    )
    );
  }
}
