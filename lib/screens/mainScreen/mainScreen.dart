import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:house_of_caju/theme/style.dart';
import 'package:house_of_caju/models/route.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:notifications/notifications.dart';
import 'components/components.dart';
import 'package:house_of_caju/models/data.dart' as globals;
import 'package:house_of_caju/screens/smartbagPageScreen/smartbag.dart';
import 'package:house_of_caju/BackgroundCollectingTask.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

double mainGlobalHeigthScreen;
int selectedIndex = 0;

class _MainScreenState extends State<MainScreen> {
  Notifications _notifications;
  StreamSubscription<NotificationEvent> _subscription;

  //BLUETOOTH
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask _collectingTask;

  bool _autoAcceptPairingRequests = false;
  //BLUETOOTH

  final GlobalKey<ScaffoldState> _scaffoldFinalKey =
      new GlobalKey<ScaffoldState>();

  double paddingTop;

  int auxReceivedGlobalItem;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    LauncherAssist.getAllApps().then((apps) {
      setState(() {
        installedApps = apps;
      });
    });

    // BLUETOOTH
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });

    // BLUETOOTH
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(NotificationEvent event) {
    print(event.packageName.toString());
    globals.results['social'].forEach((k) {
      if (k['package'] == event.packageName.toString()) {
        print("TRUE");
        String stringToBluetoothNotification =
            "${k['red']}, ${k['green']}, ${k['blue']}";
        globals.connectedApp.output
            .add(utf8.encode(stringToBluetoothNotification));
      }
    }); // }
  }

  void startListening() {
    _notifications = new Notifications();
    try {
      _subscription = _notifications.stream.listen(onData);
    } on Error catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  void onItemTapped(int index) {
    setState(() {
      if (auxReceivedGlobalItem == 123) {
      } else {
        selectedIndex = index;
      }
    });
  }

  void testConnectionBluetooth() async {
    bool ifIsAvailable = await FlutterBluetoothSerial.instance.isEnabled;
    if (ifIsAvailable) {
      globals.valueStateSmartbagBluetooth = true;
    } else {
      globals.valueStateSmartbagBluetooth = false;
    }
    print(ifIsAvailable);
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    globals.globalBuildContextMainScreen = context;
    globals.selectedIndexGlobal = selectedIndex;
    testConnectionBluetooth();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    paddingTop = MediaQuery.of(context).padding.top;
    AppBar receivedAppBar = AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "HOUSE OF CAJU",
        style: TextStyle(
            color: colorBlack10,
            fontFamily: 'Publica Sans',
            fontWeight: FontWeight.w500),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: (selectedIndex != 4)
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    textDirection: TextDirection.rtl,
                    color: colorBlack10,
                    size: 30.0,
                  ),
                  onPressed: () {
                    return _scaffoldFinalKey.currentState.openEndDrawer();
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.help,
                    textDirection: TextDirection.ltr,
                    color: colorBlack10,
                    size: 30.0,
                  ),
                  onPressed: () {
                    return _scaffoldFinalKey.currentState.openEndDrawer();
                  },
                ),
        )
      ],
      leading: Icon(
        Icons.person,
        textDirection: TextDirection.rtl,
        color: colorBlack10,
        size: 30.0,
      ),
      centerTitle: true,
    );

    mainGlobalHeigthScreen = receivedAppBar.preferredSize.height;
    paddingTop = MediaQuery.of(context).padding.top;
    double heightScreenCalc = (MediaQuery.of(context).size.height -
        paddingTop -
        (mainGlobalHeigthScreen * 2));
    double widthScreelCalc = (MediaQuery.of(context).size.width);

    globals.heightGlobal = heightScreenCalc;
    globals.widthGlobal = widthScreelCalc;
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldFinalKey,
        appBar: receivedAppBar,
        body: Center(
          child: routeCallPage(globals.selectedIndexGlobal),
        ),
        endDrawer: (selectedIndex != 4) ? callEndDrawerCreate() : null,
        bottomNavigationBar: callBottomNavigation());
  }

  Widget callBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "Página Inicial",
              style: TextStyle(
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0),
            )),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('Catálogo',
              style: TextStyle(
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.threesixty),
          title: Text('Artigos',
              style: TextStyle(
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text('Histórias',
              style: TextStyle(
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          title: Text('Smartbag',
              style: TextStyle(
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0)),
        ),
      ],
      currentIndex: globals.selectedIndexGlobal,
      selectedItemColor: colorPink,
      onTap: onItemTapped,
    );
  }

  Widget callEndDrawerCreate() {
    return Drawer(
        child: Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: paddingTop + 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    textDirection: TextDirection.ltr,
                    color: colorBlack10,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
          SideBarStfulWidget(),
        ],
      ),
    ));
  }
}
