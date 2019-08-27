import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ui/themes.dart';
import 'ui/pages-slideBarStatusSmartbag.dart';
import 'route.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlay)
class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldFinalKey =
      new GlobalKey<ScaffoldState>();
  double paddingTop;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    paddingTop = MediaQuery.of(context).padding.top;
    AppBar receivedAppBar = AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "HOUSE OF CAJU",
        style: TextStyle(color: colorBlack10),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              textDirection: TextDirection.rtl,
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

    double heightReceivedAppBar = receivedAppBar.preferredSize.height;
    double heightScreenCalc = (MediaQuery.of(context).size.height -
        paddingTop -
        (heightReceivedAppBar * 2));
    double widthScreelCalc = (MediaQuery.of(context).size.width);

    return Scaffold(
        key: _scaffoldFinalKey,
        appBar: receivedAppBar,
        body: Center(
          child:
              routeCallPage(_selectedIndex, heightScreenCalc, widthScreelCalc),
        ),
        endDrawer: callEndDrawerCreate(),
        bottomNavigationBar: callBottomNavigation());
  }

  Widget callBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt), title: Text("Página Inicial")),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Catálogo'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Artigos'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Histórias'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Smartbag'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: colorPink,
      onTap: _onItemTapped,
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
          returnStatementSmartbagWidget(),
        ],
      ),
    ));
  }
}
