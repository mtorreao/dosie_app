import 'package:dosie_app/person.dart';
import 'package:flutter/material.dart';

class PeopleList extends StatelessWidget {
  final List<dynamic> peopleList;

  PeopleList(this.peopleList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: peopleList.length,
        itemBuilder: (context, index) {
          print('index $index');
          var person = Person.fromSnapshot(peopleList[index]);
          print(person);
          return ListTile(
            title: Text(person.fullName != null ? person.fullName : person.firstName),
            onTap: () {},
          );
        });
  }
}
