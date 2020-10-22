import 'package:loginnewver2/services/auth.dart';
import 'package:flutter/material.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;

  String _password;
  bool _showPassword = false;

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Signin Screen"),
            backgroundColor: Colors.blueGrey,
            toolbarHeight: 40.0
        ),
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/skybackground2.png"),
                  fit: BoxFit.cover,
                )
            ),
            child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20, right: 20, top: 180, bottom: 20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          isDense: true, // Added this
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showPassword ? Colors.blue : Colors.grey,
                            ),
                            onPressed: (){
                              setState(() => this._showPassword = !this._showPassword);

                            },
                          )

                      ),
                      obscureText: !this._showPassword,
                    ),
                    SizedBox(height: 16,),
                    FloatingActionButton.extended(
                      onPressed: () async{
                        dynamic result = await _auth.signInAnon();
                        if(result == null) {
                          print("Error");
                        }
                        else{
                          print("Signed in!");
                        }
                      },
                      label: Text("Login"),
                    ),

                  ],
                )
            )
        )
    );
  }
}
