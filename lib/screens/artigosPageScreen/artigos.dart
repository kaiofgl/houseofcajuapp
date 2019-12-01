import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_of_caju/theme/style.dart';
import 'package:house_of_caju/models/data.dart' as globals;

class StateArtigosPageRoute extends StatefulWidget {
  @override
  _StatArtigosxPageRouteState createState() => _StatArtigosxPageRouteState();
}

class _StatArtigosxPageRouteState extends State<StateArtigosPageRoute> {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.collection('articles').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(colorPink)),
              ),
              Text(
                "Carregando dados...",
                style: TextStyle(fontFamily: 'Publica Sans'),
              )
            ],
          );
        }

        return Column(children: <Widget>[
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Text(
              "ARTIGOS",
              style: TextStyle(
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 23.0),
            ),
            alignment: Alignment.center,
          ),
          Container(
              height: globals.heightGlobal - 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data.documents[index];
                    return GestureDetector(
                      onTap: () {
                        print("tapped");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.black38),
                                top: (index == 0)
                                    ? BorderSide(
                                        width: 1.0, color: Colors.black38)
                                    : BorderSide(
                                        width: 0.0, color: Colors.black38))),
                        height: 60.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              doc['title'],
                              style: TextStyle(
                                  fontFamily: 'Publica Sans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          text: doc['article'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Publica Sans',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.0)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                    print(doc['title']);
                  }))
        ]);
      },
    );
  }
}
