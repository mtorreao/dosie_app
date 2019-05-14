import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosie_app/auth_service.dart';
import 'package:dosie_app/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonForm extends StatefulWidget {
  final Person person;

  PersonForm({this.person});

  @override
  _PersonFormState createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  final _person = Person();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.person != null) {
      _person.id = widget.person.id;
      _person.firstName = widget.person.firstName;
      _person.fullName = widget.person.fullName;
      _person.cellphone1 = widget.person.cellphone1;
      _person.likes = widget.person.likes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
            widget.person != null ? widget.person.firstName : 'Nova Pessoa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    'Dados Pessoais',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome Completo'),
                  initialValue: _person.fullName,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Não pode ser vazio';
                    } else if (value
                        .split(' ')
                        .length < 2) {
                      return 'Colocar nome e sobrenome';
                    }
                  },
                  onSaved: (value) {
                    _person.fullName = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: Text(
                    'Contatos',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  initialValue: _person.cellphone1.toString(),
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(labelText: 'Telefone 1'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Não pode ser vazio';
//                  } else if () {
//                    return 'Não é um número de telefone válido.';
                    }
                  },
                  onSaved: (value) {
                    _person.cellphone1 = int.parse(value);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: Text(
                    'Gosta de:',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _person.likes.length,
                  itemBuilder: (context, index) {
                    return Row(children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _person.likes[index],
                          decoration: InputDecoration(
                            labelText: 'Gosto ${index + 1}',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Não pode ser vazio';
                            }
                          },
                          onSaved: (value) {
                            _person.likes[index] = value;
                          },
                        ),
                      ),
                      Center(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _person.likes.removeAt(index);
                                });
                              }, icon: Icon(Icons.close))),
                    ]);
                  },
                ),
                Center(
                  child: RaisedButton.icon(
                      label: Text('Novo gosto'),
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        setState(() {
                          _person.likes.add('');
                        });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveForm,
        child: Icon(Icons.save),
      ),
    );
  }

  Future _saveForm() async {
    if (_formKey.currentState.validate()) {
      print('Validado com sucesso!');
      _formKey.currentState.save();
      FirebaseUser user = await AuthService().getUser();
      var collectionRef =
      Firestore.instance.collection('dosie_app/${user.uid}/people');
      if (_person.id != null && _person.id.isNotEmpty) {
        collectionRef.document(_person.id).updateData(_person.toMap());
      } else {
        collectionRef.add(_person.toMap());
      }

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Validado com sucesso!')));
    }
  }
}
