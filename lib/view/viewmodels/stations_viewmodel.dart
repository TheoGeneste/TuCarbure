import 'package:flutter/material.dart';
import 'package:tu_carbure/repository/stations_repository.dart';

class StationViewModel with ChangeNotifier{
  Future<List<Map<String, dynamic>>> getStationInPerimetre(longitude, latitude, perimetre) async {
    var stations = await StationRepository().getStationWithPerimetre(longitude, latitude, perimetre);
    return stations;
  }
}
