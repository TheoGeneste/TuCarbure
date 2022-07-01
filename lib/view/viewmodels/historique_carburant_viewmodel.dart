import 'package:flutter/material.dart';
import 'package:tu_carbure/repository/carburant_repository.dart';

class HistoriqueCarburantViewModel with ChangeNotifier{
  Future<List<Map<String, dynamic>>> getHistoCarburants(id) async {
    var histoCarburants = await CarburantRepository().GetHistoriquesCarburant(id);
    return histoCarburants;
  }
}
