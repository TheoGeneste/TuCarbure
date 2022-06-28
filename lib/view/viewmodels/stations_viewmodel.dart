import 'package:flutter/material.dart';
import 'package:tu_carbure/repository/stations_repository.dart';

class StationViewModel with ChangeNotifier{
  void getStationInPerimetre(longitude, latitude, perimetre){
    var stations = StationRepository().getStationWithPerimetre(longitude, latitude, perimetre);
  }
}
