import 'package:flutter/material.dart';

class GroupOptionView extends StatefulWidget {
  @override
  _GroupOptionViewState createState() => _GroupOptionViewState();
}

class _GroupOptionViewState extends State<GroupOptionView> {
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
          "Create a Group",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue[600],
      )),
      padded(
          child: RaisedButton(
        onPressed: () {},
        child: Text(
          "Join a Group",
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
          title: new Text("Group"),
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
