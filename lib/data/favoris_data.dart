import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../SharedPrefUtils.dart';

class FavorisData {
  writeFavoris(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/favorites.json');
    await file.writeAsString(text);
  }

  Future<void> addFavoris(nom, id) async {
    SharedPrefUtils.addToFav({"nom": nom, "id": id});
  }

  void removeFavoris(id) {
    SharedPrefUtils.removeFav(id);
  }
}
