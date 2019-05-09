import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonForm extends StatefulWidget {
  @override
  _PersonFormState createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DEF'),
      ),
      body: Text('ABC'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('aaa');
          var user = await FirebaseAuth.instance.signInAnonymously();
          print(user);
          var docref = await Firestore.instance.collection('dosie_app/${user.uid}/people').add({
            'first_name': 'John'
          });
          print(await docref.get());
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
