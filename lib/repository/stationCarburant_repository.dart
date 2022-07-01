import 'dart:convert';

import 'package:tu_carbure/data/stations_data.dart';

class StationCarburantRepository {
  Future<List<Map<String, dynamic>>> getStationListeCarburant(id) async {
    var carburant = await StationsData().getCarburants(id);
    var parsed =
        List<Map<String, dynamic>>.from(json.decode(carburant)['details']);
    return parsed;
  }
}
