import 'package:flutter/material.dart';
import 'package:house_of_caju/data.dart' as globals;

class StateIndexPageRoute extends StatefulWidget {
  @override
  _StateIndexPageRouteState createState() => _StateIndexPageRouteState();
}

class _StateIndexPageRouteState extends State<StateIndexPageRoute> {
  double heights = globals.heightGlobal;
   double widths = globals.widthGlobal;
  @override
  Widget build(BuildContext newContext) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.amber,
          width: widths,
          height: heights,
          child: Text('$heights'),
        )
      ],
    );
  }
}
