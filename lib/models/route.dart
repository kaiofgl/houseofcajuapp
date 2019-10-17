import 'package:flutter/material.dart';
import 'package:house_of_caju/screens/artigosPageScreen/artigos.dart';
import 'package:house_of_caju/screens/catalogoPageScreen/catalogo.dart';
import 'package:house_of_caju/screens/historiasPageScreen/historias.dart';
import 'package:house_of_caju/screens/indexPageScreen/index.dart';
import 'package:house_of_caju/screens/smartbagPageScreen/smartbag.dart';

Widget routeCallPage(index) {
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
          child: Text("$index"),
        );
      }
  }
}
