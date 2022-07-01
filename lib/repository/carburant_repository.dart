import 'dart:convert';

import 'package:tu_carbure/data/stations_data.dart';
import 'package:tu_carbure/model/station.dart';

import '../data/liste_carburant_data.dart';

class CarburantRepository{
  Future<List<Map<String, dynamic>>> getListeCarburant() async {
    var carburant =  await ListeCarburant().getListeCarburant();
    final parsed = List<Map<String, dynamic>>.from(json.decode(carburant));

    return parsed;
  }

  Future<List<Map<String, dynamic>>> GetHistoriquesCarburant(id) async {
    var histoCarburant =  await ListeCarburant().getCarburantsHistorique(id);
    final parsed = List<Map<String, dynamic>>.from(json.decode(histoCarburant));
    return parsed;
  }
}
