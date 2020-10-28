import 'package:flutter/material.dart';
import 'package:caregiverproject/Member/MemberModel.dart';

class MemberList extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<MemberList> {
  List<Member> members = [
    Member(
      name: 'Caio',
      isAdm: false,
    ),
    Member(
      name: 'Fabio',
      isAdm: false,
    ),
    Member(
      name: 'Guilherme',
      isAdm: true,
    )
  ];

  Widget _getAdmin(BuildContext context, int index) {
    return ListTile(
      title: Text(members[index].name),
      trailing: members[index].isAdm ? Icon(Icons.star) : Icon(Icons.person),
    );
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Members")),
      body: new ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.blueGrey[200],
        ),
        itemCount: members.length,
        itemBuilder: _getAdmin,
      ),
    );
  }
}
