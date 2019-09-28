import 'package:flutter/material.dart';
import 'package:house_of_caju/models/data.dart' as globals;

Color colorBlack10 = Color(0XFF404040);
Color colorPink = Color(0XFFFF37A8);
Color colorRed = Color(0XFFFF3737);

TextStyle titleStyle = TextStyle(
    fontFamily: 'Publica Sans',
    fontWeight: FontWeight.w900,
    fontSize: 18.0,
    color: colorBlack10);

TextStyle smartBagStyleTitle = TextStyle(
    fontFamily: 'Publica Sans',
    fontWeight: FontWeight.w400,
    color: (globals.valueStateSmartbagBluetooth) ? colorPink : colorRed,
    fontSize: 16.0);

TextStyle smartBagStyleTitleMain = TextStyle(
    fontFamily: 'Publica Sans',
    fontWeight: FontWeight.w400,
    color: colorBlack10,
    fontSize: 16.0);
