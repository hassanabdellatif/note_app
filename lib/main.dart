import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/views/home_screen.dart';
import 'package:notes_app/views/login_screen.dart';
import 'package:notes_app/views/register_screen.dart';
import 'package:notes_app/views/splash_screen.dart';
import 'package:provider/provider.dart';
import 'controllers/authentication/provider_auth.dart';
import 'views/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        // "addnotes": (context) => AddNotes(),
        // "testtwo": (context) => TestTwo()
      },
    );
  }
}
