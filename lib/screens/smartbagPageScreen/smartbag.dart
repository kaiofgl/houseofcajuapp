import 'package:flutter/material.dart';
import 'package:house_of_caju/models/data.dart' as globals;
import 'package:house_of_caju/theme/style.dart';
import 'components/components.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StateSmartBagPageRoute extends StatefulWidget {
  @override
  _StateSmartBagPageRouteState createState() => _StateSmartBagPageRouteState();
}

class _StateSmartBagPageRouteState extends State<StateSmartBagPageRoute> {
  bool localValue = false;
  Map<String, dynamic> allResults = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    readData().then((data) {
      setState(() {
        globals.results = data;
        print(globals.results.runtimeType);
        // globals.results = json.encode(data);
      });
    });
  }

  List<String> itemsList = List<String>.generate(100, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return (globals.results == null)
        ? Center(child: CircularProgressIndicator())
        : Container(
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
            height: 300.0,
            width: 300.0,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: globals.results['social'].length + 1,
                itemBuilder: (context, index) {
                  
                  print(globals.results['social'].length);
                  if (index != globals.results['social'].length) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                          ),
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                child: Icon(Icons.add_alarm,
                                    size: 20.0,
                                    color: (globals.results['social'][index]
                                            ['status'])
                                        ? Colors.black
                                        : Colors.black38),
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
                          caption: 'Archive',
                          color: Colors.blue,
                          icon: Icons.archive,
                          onTap: () => print('Archive'),
                        ),
                        IconSlideAction(
                          caption: 'Share',
                          color: Colors.indigo,
                          icon: Icons.share,
                          onTap: () => print('Archive'),
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Deletar',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            setState(() {
                              globals.results['social'].removeAt(index);
                              saveData();
                            });
                          },
                        ),
                      ],
                    );
                  } else {
                    return FlatButton(
                      key: UniqueKey(),
                      onPressed: () {
                        callFlutuableListApps();
                        setState(() {
                          globals.results['social']
                              .add({'name': 'Facebook', 'status': false});
                          saveData();
                        });
                      },
                      child: Container(
                        height: 35.0,
                        decoration: new BoxDecoration(
                            border:
                                Border.all(color: colorBlack10, width: 2.0)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 35.0,
                                  child: Text(
                                    "foda-se",
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
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget callFlutuableListApps() {}
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
