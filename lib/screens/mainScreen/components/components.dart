import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:house_of_caju/components/bluetooth/components/DiscoveryPage.dart';
import 'package:house_of_caju/theme/style.dart';

import 'package:house_of_caju/models/data.dart' as globals;

bool statementSmartbag = true;

class SideBarStfulWidget extends StatefulWidget {
  @override
  _SideBarStfulWidgetState createState() => _SideBarStfulWidgetState();
}

double heights = globals.heightGlobal;
double widths = globals.widthGlobal;

class _SideBarStfulWidgetState extends State<SideBarStfulWidget> {
  bool stateTapButton = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("PAINEL RÁPIDO SMARTBAG", style: titleStyle),
        Divider(height: 13, color: Colors.transparent),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SMARTBAG  ",
              style: smartBagStyleTitleMain,
            ),
            textSmartbagIsConnected(globals
                .valueStateSmartbagBluetooth), //TEXT SMARTBAG CONNECTED - DESCONNECTED
          ],
        ),
        Divider(height: 13, color: Colors.transparent),
        Container(
          color: Colors.black,
          height: 160.0,
        ),
        Divider(height: 13, color: Colors.transparent),
        Text(
          "CONFIGURAÇÕES RÁPIDAS",
          style: titleStyle,
        ),
        Divider(
          color: Colors.transparent,
          height: 10.0,
        ),
        Divider(
          color: Colors.black26,
          height: 0,
        ),
        Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 40.0,
                child: Text(
                  "LED NOTIFICAÇÃO",
                  style: TextStyle(
                      fontFamily: 'Publica Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0),
                ),
              ),
              Container(
                width: 80.0,
                child: Switch(
                  activeColor: colorPink,
                  inactiveThumbColor: colorBlack10,
                  inactiveTrackColor: colorBlack10,
                  value: globals.valueStateLedNotification,
                  onChanged: (value) {
                    print(globals.valueStateSmartbagBluetooth);
                    setState(() {
                      if (globals.valueStateSmartbagBluetooth == false) {
                        globals.valueStateLedNotification = true;
                        globals.valueStateSmartbagBluetooth = true;
                      }
                      globals.valueStateLedNotification = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black26,
          height: 0,
        ),
        Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 40.0,
                child: Text(
                  "SMARTBAG BLUETOOTH",
                  style: TextStyle(
                      fontFamily: 'Publica Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0),
                ),
              ),
              Container(
                width: 80.0,
                child: Switch(
                  activeColor: colorPink,
                  inactiveThumbColor: colorBlack10,
                  inactiveTrackColor: colorBlack10,
                  value: globals.valueStateSmartbagBluetooth,
                  onChanged: (value) {
                    future() async {
                      if (value) {
                        print(value);
                        await FlutterBluetoothSerial.instance.requestEnable();
                      } else {
                        print(value);
                        print("value");
                        await FlutterBluetoothSerial.instance.requestDisable();
                      }
                    }

                    future().then((_) {
                      setState(() {
                        globals.valueStateSmartbagBluetooth = value;
                        globals.valueStateLedNotification = value;
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black26,
          height: 0,
        ),
        clickButtonSub(context, "PÁGINA SMARTBAG", Icon(Icons.wifi), () {
          print('kkk');
        }),
        clickButtonSub(
            context, "CONECTAR NOVA SMARTBAG", Icon(Icons.bluetooth_searching),
            () {
          print("CONECTAR");
          showDialog(
              context: context,
              builder: (context) {
                return ScreenDart();
              });
        }),
      ],
    );
  }
}

@override
Widget clickButtonSub(BuildContext context, String receivedTextButton,
    Icon iconReceivedButton, Function receivedFuncion) {
  double widthChildContainer = 35.0;
  double widthBorder = 2.0;
  return Column(
    children: <Widget>[
      Container(
        child: FlatButton(
          key: UniqueKey(),
          onPressed: receivedFuncion,
          child: Container(
            height: 35.0,
            decoration: new BoxDecoration(
                border: Border.all(color: colorBlack10, width: widthBorder)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 35.0,
                      child: Text(
                        receivedTextButton,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: colorBlack10,
                            fontFamily: 'Publica Sans',
                            fontWeight: FontWeight.w600),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    height: 35.0,
                    width: widthChildContainer,
                    child: iconReceivedButton,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
