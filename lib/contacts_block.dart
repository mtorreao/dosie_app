import 'package:dosie_app/person.dart';
import 'package:flutter/material.dart';

class ContactsBlock extends StatefulWidget {
  final Person _person;

  ContactsBlock(this._person);

  @override
  _ContactsBlockState createState() => _ContactsBlockState();
}

class _ContactsBlockState extends State<ContactsBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
          ),
          child: Text(
            'Contatos',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          initialValue: widget._person.cellphone1.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: false),
          decoration: InputDecoration(labelText: 'Telefone 1'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Não pode ser vazio';
//                  } else if () {
//                    return 'Não é um número de telefone válido.';
            }
          },
          onSaved: (value) => widget._person.cellphone1 = int.parse(value),
        ),
        TextFormField(
          initialValue: widget._person.email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Não pode ser vazio';
            }
          },
          onSaved: (value) => widget._person.email = value,
        ),
      ],
    );
  }
}
