import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  var snapshots = FirebaseFirestore.instance.collection('familias').snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase test',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Deu muito bom'),
          ),
          body: StreamBuilder(
            stream: snapshots,
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
                      title: Text(item['nome']),
                    );
                  });
            },
          )),
    );
  }
}
