import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String id;
  String firstName;
  String fullName;
  int cellphone1;

  Person.fromSnapshot(DocumentSnapshot document) {
    id = document.documentID;
    this.firstName = document['first_name'];
    this.fullName = document['full_name'];
    this.cellphone1 = document['cellphone_1'];
  }

  Person({this.firstName, this.fullName, this.cellphone1});

  @override
  String toString() {
    return 'First Name: $firstName\nFull Name: $fullName\nCellphone 1: $cellphone1';
  }

  Map<String, dynamic> toMap() {
    firstName = this.fullName.split(' ')[0];
    return Map.from({
      'first_name': this.firstName,
      'full_name': this.fullName,
      'cellphone_1': this.cellphone1
    });
  }
}
