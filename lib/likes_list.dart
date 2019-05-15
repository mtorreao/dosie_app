import 'package:dosie_app/person.dart';
import 'package:flutter/material.dart';

class LikesList extends StatefulWidget {
  final Person _person;

  LikesList(this._person);

  @override
  _LikesListState createState() => _LikesListState();
}

class _LikesListState extends State<LikesList> {
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
            'Gosta de',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget._person.likes.length,
          itemBuilder: (context, index) {
            return Row(children: [
              Expanded(
                child: TextFormField(
                  initialValue: widget._person.likes[index],
                  decoration: InputDecoration(
                    labelText: 'Gosto ${index + 1}',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Não pode ser vazio';
                    }
                  },
                  onSaved: (value) => widget._person.likes[index] = value,
                ),
              ),
              Center(
                  child: IconButton(
                      onPressed: () =>
                          setState(() => widget._person.likes.removeAt(index)),
                      icon: Icon(Icons.close))),
            ]);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: RaisedButton.icon(
                label: Text('Novo gosto'),
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () => setState(() => widget._person.likes.add(''))),
          ),
        ),
      ],
    );
  }
}
