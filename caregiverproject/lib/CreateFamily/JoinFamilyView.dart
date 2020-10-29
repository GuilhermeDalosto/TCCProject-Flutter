import 'package:caregiverproject/Member/MemberListView.dart';
import 'package:caregiverproject/Services/AuthUtils.dart';
import 'package:caregiverproject/Services/dbFuture.dart';
import 'package:flutter/material.dart';

class JoinFamilyView extends StatefulWidget {
  @override
  _JoinFamilyViewState createState() => _JoinFamilyViewState();
}

class _JoinFamilyViewState extends State<JoinFamilyView> {
  static final formKey = new GlobalKey<FormState>();
  TextEditingController familyNameController = new TextEditingController();

  String _familyName;

  List<Widget> familyInfo() {
    return [
      padded(
          child: new TextFormField(
        controller: familyNameController,
        key: new Key("familyKey"),
        decoration: new InputDecoration(labelText: "Family Code"),
        autocorrect: false,
        validator: (val) => val.isEmpty ? "Code can't be Empty" : null,
        onSaved: (val) => _familyName = val,
      )),
      padded(
          child: RaisedButton(
        onPressed: () async {
          DBFuture()
              .joinGroup(familyNameController.text, await Auth().currentUser());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MemberList(
                        groupId: familyNameController.text,
                      )));
        },
        child: Text(
          "Join",
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
          title: new Text("Join your Family"),
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
