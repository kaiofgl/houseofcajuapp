import 'dart:convert';
import 'dart:io';
import 'package:house_of_caju/models/data.dart' as globals;
import 'package:path_provider/path_provider.dart';
import 'package:house_of_caju/screens/smartbagPageScreen/smartbag.dart';

Future<File> getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/random8.json");
}

saveData() async {
  final file = await getFile();
  file.writeAsString(json.encode(globals.results));
  readData();
}

Future<Map<String, dynamic>> readData() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    String fuckPath = "${directory.path}/random8.json";
    bool received;
    final file = await getFile();
    received = await File(fuckPath).exists();

    if (received == false) {
      globals.results = {'social': []};
      setRandonsAppList().then((data) {
        print(data);
      });

      final file = await getFile();

      file.writeAsString(json.encode(globals.results));

      return globals.results;
    } else {
      String contents = await file.readAsString();

      return await json.decode(contents);
    }
  } catch (e) {}
}
