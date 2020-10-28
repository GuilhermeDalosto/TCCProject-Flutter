import 'package:caregiverproject/Member/MemberModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class DBFuture {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(Member member) async {
    String retVal = "error";

    try {
      await _firestore.collection("members").doc(member.uid).set({
        'name': member.name,
        'isAdm': member.isAdm,
        'uid': member.uid,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
