import 'package:flutter/material.dart';

class CreateFamilyView extends StatefulWidget {
  @override
  _CreateFamilyViewState createState() => _CreateFamilyViewState();
}

class _CreateFamilyViewState extends State<CreateFamilyView> {
  static final formKey = new GlobalKey<FormState>();

  String _familyName;

  List<Widget> familyInfo() {
    return [
      padded(
          child: new TextFormField(
        key: new Key("familyName"),
        decoration: new InputDecoration(labelText: "Family Name"),
        autocorrect: false,
        validator: (val) => val.isEmpty ? "Name can't be Empty" : null,
        onSaved: (val) => _familyName = val,
      )),
      padded(
          child: RaisedButton(
        onPressed: () {},
        child: Text(
          "Create",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue[600],
      )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Create your Family"),
        ),
        backgroundColor: Colors.grey[300],
        body: Center(
            child: new SingleChildScrollView(
                child: new Container(
          padding: const EdgeInsets.all(30.0),
          child: new Card(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(16.0),
                    child: new Form(
                        key: formKey,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: familyInfo(),
                        ))),
              ])),
        ))));
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: child,
    );
  }
}
