import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosie_app/auth_service.dart';
import 'package:dosie_app/contacts_block.dart';
import 'package:dosie_app/likes_list.dart';
import 'package:dosie_app/person.dart';
import 'package:dosie_app/personal_block.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonForm extends StatefulWidget {
  final Person person;

  PersonForm({this.person});

  @override
  _PersonFormState createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  Person _person = Person();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.person != null) {
      _person = widget.person;
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
                PersonalBlock(_person),
                ContactsBlock(_person),
                LikesList(_person),
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

      try {
        if (_person.id != null && _person.id.isNotEmpty) {
          await collectionRef.document(_person.id).updateData(_person.toMap());
        } else {
          await collectionRef.add(_person.toMap());
        }

        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('Salvo com sucesso!')));
      } catch (e) {
        print(e);
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('Erro ao tentar salvar')));
      }
    }
  }
}
