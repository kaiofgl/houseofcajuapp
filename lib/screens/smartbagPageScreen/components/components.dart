import 'dart:convert';
import 'dart:io';

import 'package:house_of_caju/models/data.dart' as globals;
import 'package:path_provider/path_provider.dart';

Future<File> getFile() async {
  final directory = await getApplicationDocumentsDirectory();

  return File("${directory.path}/random142.json");
}

saveData() async {
  final file = await getFile();
  file.writeAsString(json.encode(globals.results));
  readData();
}

Future<Map<String, dynamic>> readData() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    String fuckPath = "${directory.path}/random142.json";
    bool received;
    final file = await getFile();
    received = await File(fuckPath).exists();
    print(received);
    if (received == false) {
      globals.results = {
        'social': [
          {'name': 'Facebook', 'status': false},
          {'name': 'ZAAAP', 'status': false},
          {'name': 'Ligação', 'status': false},
          {'name': 'Twitter', 'status': false},
          {'name': 'Tinder', 'status': false},
          {'name': 'Pinterest', 'status': false}
        ]
      };

      final file = await getFile();
      file.writeAsString(json.encode(globals.results));

      return globals.results;
    } else {
      String contents = await file.readAsString();
      print(contents);
      return await json.decode(contents);
    }
 
  } catch (e) {

  }
}
