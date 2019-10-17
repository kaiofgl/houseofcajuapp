import 'dart:math';

import 'package:flutter/material.dart';
import 'package:house_of_caju/models/data.dart' as globals;
import 'package:house_of_caju/theme/style.dart';
import 'components/components.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math' as math;

class StateSmartBagPageRoute extends StatefulWidget {
  @override
  _StateSmartBagPageRouteState createState() => _StateSmartBagPageRouteState();
}

var installedApps;

List<String> listNameAppsInstalled = List<String>();
List<bool> listItensStateAppList =
    List<bool>.generate(installedApps.length, (i) => false);
int globalIndexCallColors;

class _StateSmartBagPageRouteState extends State<StateSmartBagPageRoute> {
  bool localValue = false;

  MyDialogClass myDyalogClass;
  Widget currentPage;

  MyDialogColorsClass myDyalogColorClass;
  Widget thePageColors;

  Map<String, dynamic> allResults = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();

    readData().then((data) {
      setState(() {
        globals.results = data;
        globals.countItensActives = globals.results['social'].length;

        if (globals.results['social'].length != 0) {
          for (int i = 0; i < globals.results['social'].length; i++) {
            listItensStateAppList[globals.results['social'][i]
                ['icon-position']] = true;
          }
        }
      });
    });

    myDyalogClass = MyDialogClass(this.callback);
    currentPage = myDyalogClass;

    myDyalogColorClass = MyDialogColorsClass(this.callbackColor);
    thePageColors = myDyalogColorClass;
  }

  void callbackColor(Widget nextPageColors) {
    setState(() {
      this.thePageColors = nextPageColors;
    });
  }

  void callback(Widget nextPage) {
    setState(() {
      this.currentPage = nextPage;
    });
  }

  List<String> itemsList = List<String>.generate(100, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return (globals.results == null)
        ? Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(colorPink)))
        : futureBuilderBaseApp();
  }

  futureBuilderBaseApp() {
    return Container(
      width: globals.widthGlobal,
      height: globals.heightGlobal,
      child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            width: globals.widthGlobal,
            child: Text(
              "SMARTBAG",
              style: TextStyle(
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 23.0),
            ),
            alignment: Alignment.center,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getExpandedNotifications(),
              getExpandedStatus(),
            ],
          )
        ],
      ),
    );
  }

  getExpandedNotifications() {
    final SlidableController slidableController = SlidableController();

    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          Text(
            "NOTIFICAÇÕES",
            style: TextStyle(
                fontFamily: 'Publica Sans',
                fontWeight: FontWeight.w300,
                fontSize: 17.0),
          ),
          Container(
            height: globals.heightGlobal - 150,
            width: 300.0,
            child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: globals.results['social'].length + 1,
                itemBuilder: (context, index) {
                  if (index != globals.results['social'].length) {
                    return Slidable(
                      controller: slidableController,
                      actionPane: SlidableDrawerActionPane(),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                          ),
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                child: Image.memory(
                                  installedApps[globals.results['social'][index]
                                      ['icon-position']]['icon'],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    globals.results['social'][index]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Publica Sans',
                                        fontWeight: FontWeight.w400,
                                        color: (globals.results['social'][index]
                                                ['status'])
                                            ? Colors.black
                                            : Colors.black38),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Switch(
                                      key: ValueKey(index),
                                      activeColor: colorPink,
                                      inactiveThumbColor: colorBlack10,
                                      inactiveTrackColor: colorBlack10,
                                      value: globals.results['social'][index]
                                          ['status'],
                                      onChanged: (value) {
                                        setState(() {
                                          globals.results['social'][index]
                                              ['status'] = value;
                                          saveData();
                                        });
                                      },
                                    ),
                                  ))
                            ],
                          )),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Cores',
                          color: Color.fromARGB(
                              globals.results['social'][index]
                                  ['alpha'],
                              globals.results['social'][index]
                                  ['red'],
                              globals.results['social'][index]
                                  ['green'],
                              globals.results['social'][index]
                                  ['blue']),
                          icon: Icons.palette,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  globalIndexCallColors = index;
                                  return MyDialogColorsClass(
                                      this.callbackColor);
                                });
                          },
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Deletar',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            setState(() {
                              listItensStateAppList[globals.results['social']
                                  [index]['icon-position']] = false;

                              globals.results['social'].removeAt(index);
                              globals.countItensActives =
                                  globals.results['social'].length;
                              saveData();
                            });
                          },
                        ),
                      ],
                    );
                  }
                }),
          ),
          FlatButton(
            key: UniqueKey(),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return MyDialogClass(this.callback);
                  });
            },
            child: Container(
              height: 35.0,
              decoration: new BoxDecoration(
                  border: Border.all(color: colorBlack10, width: 2.0)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 35.0,
                        child: Text(
                          "MUDAR LISTA",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: colorBlack10,
                              fontFamily: 'Publica Sans',
                              fontWeight: FontWeight.w600),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getExpandedStatus() {
    return Expanded(
        child: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text(
            "STATUS",
            style: TextStyle(
                fontFamily: 'Publica Sans',
                fontWeight: FontWeight.w300,
                fontSize: 17.0),
          ),
          Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SMARTBAG ",
                    style: TextStyle(
                        fontFamily: 'Publica Sans',
                        fontWeight: FontWeight.w400,
                        color: colorBlack10,
                        fontSize: 12.0),
                  ),
                  Text(
                      (globals.valueStateSmartbagBluetooth)
                          ? "CONECTADA"
                          : "DESCONECTADA",
                      style: TextStyle(
                          fontFamily: 'Publica Sans',
                          fontWeight: FontWeight.w400,
                          color: (globals.valueStateSmartbagBluetooth)
                              ? colorPink
                              : colorRed,
                          fontSize: 12.0))
                ],
              )),
          Container(
            color: Colors.black,
            height: 160.0,
          ),
          Divider(height: 26.5, color: Colors.transparent),
          Divider(
            color: Colors.black26,
            height: 0,
          ),
          Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "LED NOTIFICAÇÃO",
                      style: TextStyle(
                          fontFamily: 'Publica Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
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
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "SMARTBAG",
                      style: TextStyle(
                          fontFamily: 'Publica Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
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
                      setState(() {
                        globals.valueStateSmartbagBluetooth = value;
                        globals.valueStateLedNotification = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class MyDialogColorsClass extends StatefulWidget {
  Function callbackColor;

  MyDialogColorsClass(this.callbackColor);

  @override
  _MyDialogColorsClassState createState() => _MyDialogColorsClassState();
}

class _MyDialogColorsClassState extends State<MyDialogColorsClass> {
  @override
  Widget build(BuildContext context) {
    print("called this fucked $globalIndexCallColors");
    int localReceivedAtualization = globalIndexCallColors;

    Color startCor = Color.fromARGB(
        globals.results['social'][globalIndexCallColors]['alpha'],
        globals.results['social'][globalIndexCallColors]['red'],
        globals.results['social'][globalIndexCallColors]['green'],
        globals.results['social'][globalIndexCallColors]['blue']);

    return Dialog(
        child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 25,
              child: (localReceivedAtualization != globalIndexCallColors)
                  ? Center()
                  : Image.memory(installedApps[globals.results['social']
                      [globalIndexCallColors]['icon-position']]['icon']),
            ),
            Container(
              alignment: Alignment.center,
              height: 65.0,
              child: Text(
                globals.results['social'][globalIndexCallColors]['name']
                    .toString(),
                style: TextStyle(
                    fontFamily: 'Publica Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: colorBlack10),
              ),
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
      Divider(
        color: Colors.black26,
        height: 0,
      ),
      Container(
        height: 55,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
              height: 30.0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          (globals.results['social'][globalIndexCallColors]
                                      ['status'] ==
                                  true)
                              ? "ON"
                              : "OFF",
                          style: TextStyle(
                              fontFamily: 'Publica Sans',
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Switch(
                        key: ValueKey(globalIndexCallColors),
                        activeColor: colorPink,
                        inactiveThumbColor: colorBlack10,
                        inactiveTrackColor: colorBlack10,
                        value: globals.results['social'][globalIndexCallColors]
                            ['status'],
                        onChanged: (value) {
                          this.widget.callbackColor(setState(() {
                            globals.results['social'][globalIndexCallColors]
                                ['status'] = value;
                            listItensStateAppList[globals.results['social']
                                    [globalIndexCallColors]['icon-position']] =
                                value;
                            globals.results['social'];

                            saveData();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
              child: Container(
                height: 30.0,
                child: FlatButton(
                  key: UniqueKey(),
                  onPressed: () {
                    this.widget.callbackColor(setState(() {
                      listItensStateAppList[globals.results['social']
                          [globalIndexCallColors]['icon-position']] = false;
                      globals.results['social'].removeAt(globalIndexCallColors);

                      globals.countItensActives =
                          globals.results['social'].length;
                      globalIndexCallColors = 0;
                      saveData();
                    }));

                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 35.0,
                    decoration: new BoxDecoration(
                        border: Border.all(color: colorBlack10, width: 2.0)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 35.0,
                              child: Text(
                                "REMOVER",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: colorBlack10,
                                    fontFamily: 'Publica Sans',
                                    fontWeight: FontWeight.w600),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Divider(
        color: Colors.black26,
        height: 0,
      ),
      SingleChildScrollView(
          key: UniqueKey(),
          child: new ColorPicker(
            pickerColor: startCor,
            onColorChanged: (value) {
              startCor = value;
              print("starCor $startCor");
              print(
                  "R: ${startCor.red} G: ${startCor.green} B: ${startCor.blue}");
            },
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          )),
      FlatButton(
        key: UniqueKey(),
        onPressed: () {
          this.widget.callbackColor(setState(() {
            globals.results['social'][globalIndexCallColors]['red'] =
                startCor.red;
            globals.results['social'][globalIndexCallColors]['green'] =
                startCor.green;
            globals.results['social'][globalIndexCallColors]['blue'] =
                startCor.blue;

            print(globals.results['social'][globalIndexCallColors]);
          }));
          saveData();

          globals.countItensActives = globals.results['social'].length;
          Navigator.pop(context);
        },
        child: Container(
          height: 35.0,
          decoration: new BoxDecoration(
              border: Border.all(color: colorBlack10, width: 2.0)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 35.0,
                    child: Text(
                      "SALVAR LISTA",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: colorBlack10,
                          fontFamily: 'Publica Sans',
                          fontWeight: FontWeight.w600),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]));
  }
}

class MyDialogClass extends StatefulWidget {
  Function callback;

  MyDialogClass(this.callback);
  @override
  _MyDialogClassState createState() => _MyDialogClassState();
}

class _MyDialogClassState extends State<MyDialogClass> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.satellite,
              color: Colors.transparent,
            ),
            Container(
              alignment: Alignment.center,
              height: 65.0,
              child: Text(
                "LISTA DE APLICATIVOS",
                style: TextStyle(
                    fontFamily: 'Publica Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: colorBlack10),
              ),
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: installedApps.length,
            itemBuilder: (context, index) {
              return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: Column(
                    children: <Widget>[
                      Divider(
                        color: Colors.black26,
                        height: 0,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60.0,
                                height: 30.0,
                                child: Image.memory(
                                  installedApps[index]['icon'],
                                ),
                              ),
                              Expanded(
                                  child: CheckboxListTile(
                                key: UniqueKey(),
                                title: Text(
                                  installedApps[index]['label'],
                                  style: TextStyle(
                                      fontFamily: 'Publica Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0,
                                      color: colorBlack10),
                                ),
                                activeColor: colorPink,
                                value: listItensStateAppList[index],
                                onChanged: (value) {
                                  if (value == true) {
                                    setState(() {
                                      globals.countItensActives++;
                                      listItensStateAppList[index] = value;
                                    });
                                  }
                                  if (value == false) {
                                    setState(() {
                                      globals.countItensActives--;
                                      listItensStateAppList[index] = value;
                                    });
                                  }
                                  print(globals.countItensActives);
                                },
                              )),
                            ],
                          )),
                    ],
                  ));
            }),
      ),
      FlatButton(
        key: UniqueKey(),
        onPressed: () {
          setState(() {
            globals.results['social'].clear();
          });
          saveData();

          for (int i = 0; i < listItensStateAppList.length; i++) {
            if (listItensStateAppList[i] == true) {
              for (int j = 0; j < globals.results.length; j++) {
                Random rnd;
                int min = 0;
                int max = 255;
                rnd = new Random();
                var r = min + rnd.nextInt(max - min);
                var g = min + rnd.nextInt(max - min);
                var b = min + rnd.nextInt(max - min);

                setState(() {
                  globals.results['social'].add({
                    'name': installedApps[i]['label'],
                    'status': true,
                    'package': installedApps[i]['package'],
                    'icon-position': i,
                    'red': r,
                    'green': g,
                    'blue': b,
                    'alpha': 255
                  });

                  saveData();
                });
              }
            }
          }
          this.widget.callback(setState(() {
            globals.results['social'];
          }));
          globals.countItensActives = globals.results['social'].length;
          Navigator.pop(context);
        },
        child: Container(
          height: 35.0,
          decoration: new BoxDecoration(
              border: Border.all(color: colorBlack10, width: 2.0)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 35.0,
                    child: Text(
                      "SALVAR LISTA",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: colorBlack10,
                          fontFamily: 'Publica Sans',
                          fontWeight: FontWeight.w600),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]));
  }
}

Future<String> setRandonsAppList() async {
  for (int i = 0; i < 4; i++) {
    Random rnd;
    int min = 0;
    int max = 255;
    rnd = new Random();
    var r = min + rnd.nextInt(max - min);
    var g = min + rnd.nextInt(max - min);
    var b = min + rnd.nextInt(max - min);
    globals.results['social'].add({
      'name': installedApps[(i + 1) * 2]['label'],
      'status': true,
      'package': installedApps[(i + 1) * 2]['package'],
      'icon-position': (i + 1) * 2,
      'red': r,
      'green': g,
      'blue': b,
      'alpha': 255
    });
    print(math.Random());
  }

  return globals.results.toString();
}
