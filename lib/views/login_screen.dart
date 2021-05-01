import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/controllers/authentication/provider_auth.dart';
import 'package:notes_app/views/forget_screen.dart';
import 'package:notes_app/views/home_screen.dart';
import 'package:notes_app/views/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String email, password;

  //bool keepMeLoggedIn = false;
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
    var authProvider = Provider.of<AuthProvider>(context);

    return Theme(
      data: ThemeData(
        fontFamily: "SFDisplay",
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _logo(context),
              SizedBox(
                height: 4,
              ),
              _form(context),
              ..._signin_options(context, authProvider),
              ..._notes(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage(
          'assets/images/logo.png',
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
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
                  Icons.person_outline,
                  color: Color(
                    0xff5A189A,
                  ),
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
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _signin_options(
      BuildContext context, AuthProvider authProvider) {
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
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
            child: Text(
              "SIGN IN",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () async {
              var user =
                  await authProvider.signIn(email, password, _formKey, context);
              if (user != null) {
                Navigator.of(context).pushReplacementNamed(HomeScreen.id);
              }
            },
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(0xff4a4fb7),
              ),
            ),
            label: Text(
              "SIGN IN WITH FACEBOOK",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: Icon(
              FontAwesomeIcons.facebookF,
            ),
            onPressed: () {},
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(0xffffffff),
              ),
            ),
            label: Text(
              "SIGN IN WITH GMAIL",
              style: TextStyle(
                color: Color(0xFFb92c3c),
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: Icon(
              FontAwesomeIcons.google,
              color: Color(0xFFb92c3c),
            ),
            onPressed: () {},
          ),
        ),
      ),
    ];
  }

  List<Widget> _notes(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don’t have an account? "),
            InkWell(
              child: Text(
                "Register",
                style: TextStyle(
                  color: Color(0xff7B2CBF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(RegisterScreen.id);
              },
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("By logging in you agree to our app "),
                Text(
                  "Terms and ",
                  style: TextStyle(
                    color: Color(0xff5A189A),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Services, Privacy policy, ",
                  style: TextStyle(
                    color: Color(0xff5A189A),
                  ),
                ),
                Text("and "),
                Text(
                  "Content policy",
                  style: TextStyle(
                    color: Color(0xff5A189A),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ];
  }
}
