import 'dart:convert';

import 'package:http/http.dart' as http;

class StationsData{

   Future<String> getStationWithPerimetre(double longitude, double latitude, int perimetre, Map<String, bool> tableauCarburant) async {
     String carburants= "";
     tableauCarburant.forEach((key, value) {
       if(value == true){
        carburants += "&codeEuropeen=" + key;
       }
     });
    var url = Uri.parse('http://theslipe.myddns.me:8080/stations?latitude=$latitude&longitude=$longitude&distance=$perimetre'+carburants);
    print(url);
    var stations = await http.get(url);
    return stations.body;
  }
}
