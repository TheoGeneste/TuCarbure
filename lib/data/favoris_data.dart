import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FavorisData{
  writeFavoris(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/favorites.json');
    await file.writeAsString(text);
  }

  Future<Map<String, dynamic>?> getFavoris() async {
    String text = "";
    Map<String,dynamic>? decode;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/favorites.json');
      text = await file.readAsString();
      print(text);
    } catch(e) {
      print("Couldn't read file");
    }

    try {
      decode = jsonDecode(text) as Map<String,dynamic>;
    } catch(e) {
      print("Couldn't decode json");
      _init();
    }
    return decode;
  }

  Future<void> addFavoris(nom, id) async {
    var json = await FavorisData().getFavoris();

    json?["results"].add({"nom":"test", "id":5});
    await writeFavoris(json.toString());
    await FavorisData().getFavoris();
  }
  
  _init() {
    writeFavoris("{\"results\":[]}");
  }

}
