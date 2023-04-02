// ignore_for_file: prefer_const_constructors, camel_case_types, unnecessary_new, unused_import, unused_local_variable

import 'package:app001/firebase_options.dart';
import 'package:app001/homePage.dart';
import 'package:app001/login.dart';
import 'package:app001/main02.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff17181C);
    Color bar = Color.fromARGB(255, 12, 13, 16);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        canvasColor: bar,
      ),
      home: splash(),
    );
  }
}

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      duration: 3000,
      imageSrc: 'assets/splash.png',
      imageSize: 800,
      backgroundColor: Colors.black,
      textStyle: TextStyle(color: Colors.grey),
      navigateRoute: Login(),
    );
  }
}
