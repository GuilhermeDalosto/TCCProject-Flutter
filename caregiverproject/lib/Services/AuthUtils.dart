import 'dart:async';
import 'package:caregiverproject/Member/MemberModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dbFuture.dart';

abstract class AuthProtocol {
  Future<Member> currentUser();
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthProtocol {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.toString();
  }

  Future<String> createUser(String email, String password) async {
    UserCredential member = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    Member _member = Member(
      uid: member.user.uid,
      name: member.user.email,
      isAdm: false,
    );
    String _returnString = await DBFuture().createUser(_member);
    if (_returnString == "success") {
      print("success");
    }
    return member.toString();
  }

  Future<Member> currentUser() async {
    User user = _firebaseAuth.currentUser;
    if (user != null) {
      return Member(isAdm: false, name: user.displayName, uid: user.uid);
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
