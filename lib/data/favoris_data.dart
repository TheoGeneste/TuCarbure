import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FavorisData{
  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/favorites.json');
    await file.writeAsString(text);
  }

  Future<String> getFavoris() async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/favorites.json');
      print('${directory.path}/favorites.json');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }
  
  _init(){
    _write("{[{\"id\":\"1\", \"name\":\"Leclerc\"}]}");
  }

}
