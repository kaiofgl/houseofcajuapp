import 'package:flutter/material.dart';

Widget routeCallPage(index, heightScreenCalc, widthScreelCalc) {
  switch (index) {
    case 0:
      {print('0');}
      break;
    case 1:
      {print('1');}
      break;
    case 2:
      {print('2');}
      break;
    case 3:
      {print('3');}
      break;
    case 4:
      {print('4');}
      break;
  }
  return Container(
    color: Colors.red,
    height: heightScreenCalc,
    width: widthScreelCalc,
    child: Text("$index"),
  );
}
