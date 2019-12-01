import 'package:flutter/material.dart';
import 'package:house_of_caju/components/bluetooth/components/DiscoveryPage.dart';

class StateIndexPageRoute extends StatefulWidget {
  @override
  _StateIndexPageRouteState createState() => _StateIndexPageRouteState();
}

class _StateIndexPageRouteState extends State<StateIndexPageRoute> {
  @override
  Widget build(BuildContext newContext) {
    return Column(children: <Widget>[
      Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        child: Text(
          "PÁGINA INICIAL",
          style: TextStyle(
              fontFamily: 'Publica Sans',
              fontWeight: FontWeight.w800,
              fontSize: 23.0),
        ),
        alignment: Alignment.center,
      ),
      Container(
        child: Text("FUCK DA POLISAA"),
      )
    ]);
  }
}
