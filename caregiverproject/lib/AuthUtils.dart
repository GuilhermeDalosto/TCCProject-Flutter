import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthUtils {
  Future<String> currentUser();
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthUtils {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.toString();
  }

  Future<String> createUser(String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.toString();
  }

  Future<String> currentUser() async {
    User user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.toString();
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

}