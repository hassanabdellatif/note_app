import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/controllers/authentication/provider_auth.dart';
import 'package:notes_app/controllers/firestore/database.dart';
import 'package:notes_app/models/user.dart';
import 'package:notes_app/views/home_screen.dart';
import 'package:notes_app/views/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String username, email, password, phone;

  bool _obscureText = false;
  String errorMessage;

  OutlineInputBorder enaBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ),
  );
  OutlineInputBorder focBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      color: Color(0xff9D4EDD),
    ),
  );

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = AuthProvider();
    return Theme(
      data: ThemeData(
        fontFamily: "SFDisplay",
      ),
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 50),
            Center(
              child: Image(
                image: AssetImage(
                  'assets/images/logo.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {
                        username = val;
                      },
                      validator: (val) {
                        if (val.length > 100) {
                          return "username can't to be larger than 100 letter";
                        }
                        if (val.length < 5) {
                          return "username can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff5A189A),
                        ),
                        hintText: "Username",
                        enabledBorder: enaBorder,
                        focusedBorder: focBorder,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        email = val;
                      },
                      validator: (val) {
                        if (val.length > 100) {
                          return "Email can't to be larger than 100 letter";
                        }
                        if (val.length < 12) {
                          return "Email can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff5A189A),
                        ),
                        hintText: "Email",
                        enabledBorder: enaBorder,
                        focusedBorder: focBorder,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        password = val;
                      },
                      validator: (val) {
                        if (val.length > 100) {
                          return "Password can't to be larger than 100 letter";
                        }
                        if (val.length < 4) {
                          return "Password can't to be less than 4 letter";
                        }
                        return null;
                      },
                      obscureText: !_obscureText,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(
                            0xff5A189A,
                          ),
                        ),
                        hintText: "Password",
                        enabledBorder: enaBorder,
                        focusedBorder: focBorder,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        suffixIcon: IconButton(
                          color: Color(0xff5A189A),
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        phone = val;
                      },
                      validator: (val) {
                        if (val.length > 11) {
                          return "Phone can't to be larger than 11 letter";
                        }
                        if (val.length < 11) {
                          return "Phone can't to be less than 11 letter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color(0xff5A189A),
                        ),
                        hintText: "Phone",
                        enabledBorder: enaBorder,
                        focusedBorder: focBorder,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text("Already have an account? "),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(LoginScreen.id);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Color(0xff7B2CBF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xff7B2CBF),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          var formData = _formKey.currentState;
                          if (formData.validate()) {
                            formData.save();
                            UserCredential response =
                                await authProvider.signUp(email, password);
                            if (response != null) {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.id);
                            } else {
                              AwesomeDialog(
                                context: context,
                                title: "Error",
                                body: Text(
                                  authProvider.errorMessage.toString(),
                                ),
                              )..show();
                            }
                            await storeData(context, authProvider);
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future storeData(BuildContext context, AuthProvider authProvider) async {
    Database database = Database();
    await database.addNoter(
      Notetaker(
        id: authProvider.currentUser(),
        username: username.trim(),
        email: email.trim(),
        password: password.trim(),
        phone: phone.trim(),
        createdAt: DateTime.now(),
      ),
    );
  }
}
