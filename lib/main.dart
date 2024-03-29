import 'package:aquasafe20xx/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaSafe WebApp',
      theme: ThemeData(
        backgroundColor: Colors.deepOrange,
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        brightness: Brightness.dark,
      ),
      home: LoginPage(),
    );
  }
}
