import 'package:caregiverproject/Member/MemberModel.dart';
import 'package:caregiverproject/Services/AuthUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class DBFuture {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createGroup(String groupName, Member user) async {
    String retVal = "error";
    List<String> members = List();

    try {
      members.add(user.uid);
      DocumentReference _docRef;

      _docRef = await _firestore.collection("groups").add({
        'name': groupName,
        'members': members,
        'groupCreated': Timestamp.now(),
      });
      await _firestore
          .collection("members")
          .doc(user.uid)
          .update({'groupId': _docRef.id, 'isAdm': true});

      retVal = _docRef.id.toString();
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId, Member member) async {
    String retVal = "error";
    List<String> members = List();
    try {
      members.add(member.uid);
      print('Passou 1');
      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });

      await _firestore.collection("members").doc(member.uid).update({
        'groupId': groupId,
      });

      retVal = "success";
    } on PlatformException catch (e) {
      retVal = "Tenha certeza que esse é o Id certo!";
      print(e);
    } catch (e) {
      print(e);
    }

    return retVal;
  }

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
