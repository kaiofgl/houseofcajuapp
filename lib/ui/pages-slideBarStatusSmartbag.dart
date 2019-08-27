import 'package:flutter/material.dart';
import 'themes.dart';

bool statementSmartbag = true;

Widget returnStatementSmartbagWidget() {
  return Column(
    children: <Widget>[
      Text("PAINEL RÁPIDO SMARTBAG", style: titleStyle),
      Divider(height: 13, color: Colors.transparent),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "SMARTBAG  ",
            style: TextStyle(
                fontFamily: 'Publica Sans',
                fontWeight: FontWeight.w400,
                color: colorBlack10,
                fontSize: 17.0),
          ),
          textSmartbagIsConnected(false),//TEXT SMARTBAG CONNECTED - DESCONNECTED
        ],
      ),
      Divider(height: 13, color: Colors.transparent),
      Container(
        color: Colors.black,
        height: 160.0,
      ),
      Divider(height: 13, color: Colors.transparent),
      Text("CONFIGURAÇÕES RÁPIDAS", style: titleStyle,)
    ],
  );
}

Widget textSmartbagIsConnected(statementSmartbag) {
  return Text((statementSmartbag) ? "CONECTADA" : "DESCONECTADA",
      style: TextStyle(
          fontFamily: 'Publica Sans',
          fontWeight: FontWeight.w400,
          color: (statementSmartbag) ? colorPink : colorRed,
          fontSize: 17.0));
}

Widget getAndReturnConnectionIsEnabled() {}
