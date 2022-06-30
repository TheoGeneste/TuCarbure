import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavorisData{
  writeFavoris(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/favorites.json');
    await file.writeAsString(text);
  }

  Future<void> addFavoris(nom, id) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<dynamic> list = json.decode(prefs.get('fav').toString());

    list.add(Map.of({"nom": nom, "id": id}));

    String encodedMap = json.encode(list);
    prefs.setString('fav', encodedMap);
  }

}
