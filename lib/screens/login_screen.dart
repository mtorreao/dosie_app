import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class LoginScreen extends StatelessWidget {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              height: 150,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: loginController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.alternate_email),
                        hintText: 'Email',
                        labelText: 'Email',
                        hasFloatingPlaceholder: true),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'Password'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RaisedButton.icon(
                      color: Colors.blueAccent,
                      onPressed: () async {
                        var user = await FirebaseAuth.instance
//                            .createUserWithEmailAndPassword(
//                                email: 'abc@abc.com', password: 'asdf1234');
                            .signInWithEmailAndPassword(
                                email: loginController.text,
                                password: passwordController.text);
                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage('')));
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
