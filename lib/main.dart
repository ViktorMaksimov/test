import 'package:flutter/material.dart';
import 'package:flutter_mentor_quiz_app_tut/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz',
      theme: ThemeData(
        primaryColor: Color(0xFF55C1EF),
      ),
      home: Home(),
    );
  }
}
