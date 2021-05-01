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

  signIn(String email, String password, final formKey,
      BuildContext context) async {
    var formData = formKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        notifyListeners();
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("No user found for that email"),
          )..show();
        } else if (e.code == 'wrong-password') {
          // Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("Wrong password provided for that user"),
          )..show();
        }
        notifyListeners();
      }
    } else {
      print("Not Valid");
    }
  }

  signUp(String email, String password, final formKey,
      BuildContext context) async {
    var formData = formKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        notifyListeners();
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("Password is to weak"),
          )..show();
        } else if (e.code == 'email-already-in-use') {
          // Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("The account already exists for that email"),
          )..show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  currentUser() {
    User user = _auth.currentUser;
    return user != null ? user.uid : null;
  }
}
