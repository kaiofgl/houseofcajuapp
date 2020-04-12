import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:house_of_caju/theme/style.dart';
import 'package:house_of_caju/models/data.dart' as globals;

class ScreenDart extends StatefulWidget {
  final bool start;

  const ScreenDart({this.start = true});
  @override
  _ScreenDartState createState() => _ScreenDartState();
}

class _ScreenDartState extends State<ScreenDart> {
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;

  _ScreenDartState();

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });
    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        results.add(r);
        print(results);
      });
    });

    _streamSubscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var result;
    BluetoothConnection connection;
    bool bonded = false;
    var children2 = <Widget>[
      Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.close,
                  color: Colors.transparent,
                ),
                Container(
                    alignment: Alignment.center,
                    height: 65.0,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "CONECTAR SMARTBAG",
                          style: TextStyle(
                              fontFamily: 'Publica Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black),
                        ),
                        Icon(Icons.bluetooth_searching)
                      ],
                    )),
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ])),
      Expanded(
        child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              result = results[index];
              return AnimatedCard(
                  key: UniqueKey(),
                  direction:
                      AnimatedCardDirection.right, //Initial animation direction
                  duration: Duration(seconds: 1),
                  child: Container(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(Icons.devices),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            result.device.name,
                            style: TextStyle(
                                fontFamily: 'Publica Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: FlatButton(
                            key: UniqueKey(),
                            padding: EdgeInsets.only(left: 0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.bluetooth_searching,
                                  size: 19,
                                ),
                                Text(
                                  (result.device.isBonded)
                                      ? "CONECTAR"
                                      : "PAREAR",
                                  style: TextStyle(
                                      fontFamily: 'Publica Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: (!bonded) ? 11 : 9),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              // if (globals.stateConnectedApp == true) {
                              //   globals.connectedApp.close();
                              // }

                              globals.connectedApp =
                                  await BluetoothConnection.toAddress(
                                      result.device.address);
                              setState(() {
                                globals.stateConnectedApp = true;
                              });
                              // print(globals.connectedApp.isConnected);
                              globals.connectedApp.output
                                  .add(utf8.encode("successfullyconnected"));

                              globals.connectedApp.input
                                  .listen((Uint8List data) {
                                String dataReceived =
                                    ascii.decode(data).toString();
                                if (dataReceived == "c") {
                                  globals.connectedApp.output.add(
                                      utf8.encode("successfullyconnected"));
                                  print("RECALL");
                                }
                              }).onDone(() {
                                print("FINALIZADO");
                              });
                            },
                          ),
                        ),
                      ),
                    ]),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black38),
                          top: (index == 0)
                              ? BorderSide(width: 1.0, color: Colors.black38)
                              : BorderSide(width: 0.0, color: Colors.black38)),
                      color: Colors.white,
                    ),
                  ));
            }),
      ),
      FlatButton(
        onPressed: () async {
          print(globals.connectedApp);

          globals.connectedApp.output.add(utf8.encode("red: 244"));
          await globals.connectedApp.output.allSent;
          print("SEND ALL");
        },
        child: Text("debug test"),
      ),
      FlatButton(
        key: UniqueKey(),
        onPressed: _restartDiscovery,
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          height: 35.0,
          decoration: new BoxDecoration(
              border: Border.all(color: colorBlack10, width: 2.0)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                !isDiscovering
                    ? Expanded(
                        child: Container(
                          height: 35.0,
                          child: Text(
                            "ATUALIZAR",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: colorBlack10,
                                fontFamily: 'Publica Sans',
                                fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.center,
                        ),
                      )
                    : Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 35.0),
                            child: Container(
                              height: 35.0,
                              child: Text(
                                "PROCURANDO...",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: colorBlack10,
                                    fontFamily: 'Publica Sans',
                                    fontWeight: FontWeight.w600),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                          Center(
                              child: Container(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(colorPink),
                            ),
                          ))
                        ],
                      )),
              ],
            ),
          ),
        ),
      )
    ];

    return Dialog(child: Column(children: children2));
  }
}
