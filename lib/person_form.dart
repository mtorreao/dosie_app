import 'package:flutter/material.dart';

class PersonForm extends StatefulWidget {
  @override
  _PersonFormState createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('DEF'),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome Completo'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Não pode ser vazio';
                  } else if (value.split(' ').length < 2) {
                    return 'Colocar nome e sobrenome';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone 1'),
              ),
              Text('Contatos'),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone 2'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Gostos', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            print('Validado com sucesso!');
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text('Validado com sucesso!')));
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
