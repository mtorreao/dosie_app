import 'package:dosie_app/people_list.dart';
import 'package:dosie_app/person_form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser user;

  @override
  void initState() {
    Firestore.instance.settings(persistenceEnabled: true);
    setUser();
    super.initState();
  }

  setUser() async {
    var user = await FirebaseAuth.instance.signInAnonymously();
    setState(() {
      this.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder(
            builder: (context, snapshot) {
              print(snapshot.data.documents);
              if (snapshot.hasData) {
                return PeopleList(snapshot.data.documents);
              } else {
                return CircularProgressIndicator();
              }
            },
            stream: this.user != null
                ? Firestore.instance
                    .collection('/dosie_app/${user.uid}/people')
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
  }
}
