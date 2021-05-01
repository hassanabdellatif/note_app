import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notes_app/views/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSeen = true;
  bool _isLogged = false;

  @override
  void initState() {
    delayRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image(
            image: AssetImage(
              "assets/images/splash.png",
            ),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Transform.translate(
          offset: Offset(0, 200),
          child: SpinKitRing(
            color: Color(0xff5A189A),
            size: 45,
            lineWidth: 5,
          ),
        ),
      ],
    );
  }

  void _checkSeen() async {}

  void _checkLoggedIn() async {}

  delayRoute() {
    Future.delayed(Duration(seconds: 3), () {}).then((value) {
      if (_isSeen) {
        Navigator.of(context).pushReplacementNamed(OnBoardingScreen.id);
      }
    });
  }
}
