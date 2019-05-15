import 'package:dosie_app/person.dart';
import 'package:flutter/material.dart';

class PersonalBlock extends StatefulWidget {
  final Person _person;

  PersonalBlock(this._person);

  @override
  _PersonalBlockState createState() => _PersonalBlockState();
}

class _PersonalBlockState extends State<PersonalBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: Text(
            'Dados Pessoais',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome Completo'),
          initialValue: widget._person.fullName,
          validator: (value) {
            if (value.isEmpty) {
              return 'Não pode ser vazio';
            } else if (value.split(' ').length < 2) {
              return 'Colocar nome e sobrenome';
            }
          },
          onSaved: (value) => widget._person.fullName = value,
        ),
      ],
    );
  }
}
