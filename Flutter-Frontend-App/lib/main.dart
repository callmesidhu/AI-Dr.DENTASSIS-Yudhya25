import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/screen_login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dr. Dentassis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // Set ScreenHome as the home screen
      home: ScreenLogin()
    );
  }
}
