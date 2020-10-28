import 'package:flutter/material.dart';

class FamilyOptionView extends StatefulWidget {
  @override
  _FamilyOptionViewState createState() => _FamilyOptionViewState();
}

class _FamilyOptionViewState extends State<FamilyOptionView> {
  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: child,
    );
  }

  List<Widget> usernameAndPassword() {
    return [
      padded(
          child: RaisedButton(
        onPressed: () {},
        child: Text(
          "Create a Family",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue[600],
      )),
      padded(
          child: RaisedButton(
        onPressed: () {},
        child: Text(
          "Join a Family",
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
          title: new Text("Family"),
        ),
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(30.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: usernameAndPassword(),
              )),
        ));
  }
}
