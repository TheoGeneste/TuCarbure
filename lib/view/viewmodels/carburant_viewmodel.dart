import 'package:flutter/material.dart';

import '../../repository/carburant_repository.dart';

class CarburantViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getListeCarburant() async {
    var json = await CarburantRepository().getListeCarburant();
    return json;
  }
}
