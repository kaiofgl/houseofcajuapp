import 'package:flutter/material.dart';
import 'pages/artigos.dart';
import 'pages/catalogo.dart';
import 'pages/historias.dart';
import 'pages/index.dart';
import 'pages/smartbag.dart';


Widget routeCallPage(index, heightScreenCalc, widthScreelCalc) {
  
  switch (index) {
    case 0:
      {
        return StateIndexPageRoute();
      }
      break;
    case 1:
      {
        return StateCatalogoPageRoute();
      }
      break;
    case 2:
      {
        return StateArtigosPageRoute();
      }
      break;
    case 3:
      {
        return StateHistoriasPageRoute();
      }
      break;
    case 4:
      {
        return StateSmartBagPageRoute();
      }
      break;
    default:
      {
        return Container(
          color: Colors.red,
          height: heightScreenCalc,
          width: widthScreelCalc,
          child: Text("$index"),
        );
      }
  }
}
