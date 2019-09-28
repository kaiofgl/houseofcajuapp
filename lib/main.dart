import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_of_caju/screens/mainScreen/mainScreen.dart';

void main() {
  
  runApp(MaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
