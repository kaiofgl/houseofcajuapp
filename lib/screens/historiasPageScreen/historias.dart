import 'package:house_of_caju/models/data.dart' as globals;
import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_of_caju/theme/style.dart';

class StateHistoriasPageRoute extends StatefulWidget {
  @override
  _StatHistoriasPPageRouteState createState() =>
      _StatHistoriasPPageRouteState();
}

class _StatHistoriasPPageRouteState extends State<StateHistoriasPageRoute> {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          db.collection('hist_names_comp').orderBy('number_ref').snapshots(),
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

        return Column(
          children: <Widget>[
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "HISTÓRIAS",
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
                  String mainStringNumber = "000000";
                  return AnimatedCard(
                      child: Container(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              //GAMB SEMPRE TEM
                              "HC${mainStringNumber.substring(doc['number_ref'].toString().length)}${doc['number_ref'].toString()}",
                              style: TextStyle(
                                  fontFamily: 'Publica Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              doc['name_comp'].toString().toUpperCase(),
                              style: TextStyle(
                                  fontFamily: 'Publica Sans',
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        Expanded(
                            child: FlatButton(
                          key: UniqueKey(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                  height: 40.0,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.close,
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 65.0,
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  doc['name_comp']
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Publica Sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16.0,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            )),
                                                        IconButton(
                                                            icon: Icon(
                                                                Icons.close),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            })
                                                      ])),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 10.0),
                                                child: Text(
                                                  "A HISTÓRIA...",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Publica Sans',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.0,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SingleChildScrollView(
                                                    child: Stack(
                                                  children: <Widget>[
                                                    Text(
                                                      doc['history_comp'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Publica Sans',
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 15.0,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                )),
                                              )
                                            ],
                                          )));
                                });
                          },
                          child: Container(
                            height: 35.0,
                            decoration: new BoxDecoration(
                                border: Border.all(
                                    color: colorBlack10, width: 2.0)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 35.0,
                                      child: Text(
                                        "HISTÓRIA",
                                        style: TextStyle(
                                            fontSize: 11.0,
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
                        ))
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black38),
                          top: (index == 0)
                              ? BorderSide(width: 1.0, color: Colors.black38)
                              : BorderSide(width: 0.0, color: Colors.black38)),
                      color: Colors.white,
                    ),
                  ));
                },
              ),
            )
          ],
        );
      },
    );
  }
}
