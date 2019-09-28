import 'package:flutter/material.dart';
import 'package:house_of_caju/theme/style.dart';

class MainPageInitialScreen extends StatefulWidget {
  @override
  _MainPageInitialScreenState createState() => _MainPageInitialScreenState();
}

class _MainPageInitialScreenState extends State<MainPageInitialScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar receivedAppBar = AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "HOUSE OF CAJU",
        style: TextStyle(color: colorBlack10),
      ),
      leading: Icon(
        Icons.arrow_back_ios,
        textDirection: TextDirection.ltr,
        color: colorBlack10,
        size: 30.0,
      ),
      centerTitle: true,
    );

    return Scaffold(
      appBar: receivedAppBar,
      body: Text("ola"),
    );
  }
}
