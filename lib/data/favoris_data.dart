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
    Map<String,dynamic>? decode = null;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/favorites.json');
      text = await file.readAsString();
      decode = jsonDecode(text) as Map<String,dynamic>;
    } catch (e) {
      print("Couldn't read file");
    }
    return decode;
  }


  
  _init(){
    writeFavoris("{\"results\":[{\"id\":\"1\", \"name\":\"Leclerc\"},{\"id\":\"2\", \"name\":\"Total\"},{\"id\":\"3\", \"name\":\"Total\"}]}");
  }

}
