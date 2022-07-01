import 'package:flutter/material.dart';

import '../../repository/marques_repository.dart';

class MarquesViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getListeMarques() async {
    var json = await MarquesRepository().getListeMarques();
    return json;
  }
}
