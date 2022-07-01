import 'package:flutter/material.dart';
import 'package:tu_carbure/repository/stationCarburant_repository.dart';
import 'package:tu_carbure/repository/stations_repository.dart';

class StationsCarburantsViewModel with ChangeNotifier{
  Future<List<Map<String, dynamic>>> getStationCarburant(id) async {
    var stations = await StationCarburantRepository().getStationListeCarburant(id);
    return stations;
  }
}
