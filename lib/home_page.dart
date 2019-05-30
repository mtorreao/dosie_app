import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosie_app/people_list.dart';
import 'package:dosie_app/person_form.dart';
import 'package:dosie_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  StatelessElement createElement() {
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var loggedIn = user != null;
    if (loggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
          actions: <Widget>[
            IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.power_settings_new,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                })
          ],
        ),
        body: Column(children: [
          Expanded(
            child: StreamBuilder(
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      return PeopleList(snapshot.data.documents);
                    } else {
                      return Center(
                        child: Text('Ocorreu um erro inesperado'),
                      );
                    }
                    break;
                  case ConnectionState.none:
                    return Center(
                      child: Text('Lista vazia'),
                    );
                    break;
                  case ConnectionState.done:
                    return Center(
                      child: Text('Ocorreu um erro inesperado'),
                    );
                    break;
                }
              },
              stream: user != null
                  ? Firestore.instance
                  .collection('dosie_app/${user.uid}/people')
                  .snapshots()
                  : null,
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PersonForm()));
          },
          child: Icon(Icons.add),
        ),
      );
    } else {
      return LoginScreen();
    }
  }
}
