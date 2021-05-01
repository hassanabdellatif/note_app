import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth;
  String errorMessage;
  String message;
  User _user;
  User get user => _user;

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        _user = user;
      }
      notifyListeners();
    });
  }

  signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage = "Your email is invalid";
        print('Invalid email');
      }
      if (e.code == 'user-not-found') {
        errorMessage = "User not found";
        print('Hi, User not found');
      } else if (e.code == 'wrong-password') {
        errorMessage = "Your password is not correct";
      }
      notifyListeners();
    } catch (e) {
      print(e.code);
    }
  }

  signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage = "Your email is invalid";
        print('Invalid email');
      }
      notifyListeners();
    } catch (e) {
      print(e.code);
    }
  }

  currentUser() {
    User user = _auth.currentUser;
    return user != null ? user.uid : null;
  }
}
