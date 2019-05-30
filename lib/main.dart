import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosie_app/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Firestore.instance.settings(persistenceEnabled: true);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            stream: FirebaseAuth.instance.onAuthStateChanged)
      ],
      child: MaterialApp(
          title: 'Dosie App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: HomePage('Dosie App')),
    );
  }
}
