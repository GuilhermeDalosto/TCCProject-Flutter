import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:caregiverproject/Member/MemberModel.dart';

class MemberList extends StatelessWidget {
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

  String groupId;
  MemberList({
    this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase test',
      home: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('members')
                .where('groupId', isEqualTo: groupId)
                .snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text('Nenhuma familia cadastrada ainda'),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int i) {
                    var item = snapshot.data.docs[i].data();

                    return ListTile(
                      title: Text(item['name']),
                    );
                  });
            },
          )),
    );
  }
}
