import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String id;
  String firstName;
  String fullName;
  int cellphone1;
  List<String> likes = List<String>();
  String email;

  Person.fromSnapshot(DocumentSnapshot document) {
    id = document.documentID;
    this.firstName = document['first_name'];
    this.fullName = document['full_name'];
    this.cellphone1 = document['cellphone_1'];
    this.email = document['email'];
    likes = List<String>();
    try {
      if (document['likes'] != null) {
        this.likes = List<String>.from(document['likes']);
      }
    } catch (e) {}
  }

  Person(
      {this.firstName, this.fullName, this.cellphone1, this.likes, this.email});

  @override
  String toString() {
    return 'Full Name: $fullName, Email: $email, Cellphone 1: $cellphone1, Likes: $likes';
  }

  Map<String, dynamic> toMap() {
    firstName = this.fullName.split(' ')[0];
    return Map.from({
      'first_name': this.firstName,
      'full_name': this.fullName,
      'cellphone_1': this.cellphone1,
      'email': email,
      'likes': likes
    });
  }
}
