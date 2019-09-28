import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:house_of_caju/models/data.dart' as globals;
import 'package:path_provider/path_provider.dart';

dynamic getJsonAppsNotification() {
  globals.results = {
    'social': [
      {'name': 'Facebook', 'status': false},
      {'name': 'Whatsapp', 'status': false},
      {'name': 'Ligação', 'status': false},
      {'name': 'Twitter', 'status': false},
      {'name': 'Tinder', 'status': false},
      {'name': 'Pinterest', 'status': false}
    ]
  };
 return globals.results;
}
Future<File> getFile() async{
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/data.json");
}

Future<File> saveData() async{
  String data = json.encode(globals.results);
  print(data);
}