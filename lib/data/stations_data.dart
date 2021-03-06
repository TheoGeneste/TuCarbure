import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tu_carbure/data/global_data.dart';
import 'package:tu_carbure/view/viewmodels/stationsCarburants_viewmodel.dart';

import '../view/viewmodels/carburant_viewmodel.dart';
import 'login_data.dart';

class StationsData {
  Future<String> getStationWithPerimetre(double longitude, double latitude,
      int perimetre, Map<String, bool> tableauCarburant) async {
    String carburants = "";
    tableauCarburant.forEach((key, value) {
      if (value == true) {
        carburants += "&codeEuropeen=" + key;
      }
    });
    var url = Uri.parse(
        'http://theslipe.myddns.me:8080/stations?latitude=$latitude&longitude=$longitude&distance=$perimetre' +
            carburants);
    var stations = await http.get(url);
    return stations.body;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> addStation(
      String nom,
      String description,
      String rue,
      String ville,
      String codePostal,
      List<TextEditingController> listeController) async {
    var carburants = await CarburantViewModel().getListeCarburant() as List;
    var index = 0;
    var listeCarburantName = [];
    var listeCarburantDetails = [];
    for (var i in listeController) {
      if (i.text != "") {
        listeCarburantName.add(carburants[index]['nom']);

        listeCarburantDetails.add({
          "nom": carburants[index]['nom'],
          "codeEuropeen": carburants[index]['code'],
          "disponible": true,
          "prix": i.text
        });
        index++;
      }
    }

    var latitude = null;
    var longitude = null;
    var global = await GlobalData().getGlobal();
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      longitude = position.longitude;
      latitude = position.latitude;
    });
    final body = {
      "marque": {"nom": nom, "description": description},
      "adresse": {
        "rue": rue,
        "ville": ville,
        "codePostal": codePostal,
        "longitude": longitude,
        "latitude": latitude
      },
      "carburants": {
        "listeCarburants": listeCarburantName,
        "details": listeCarburantDetails
      }
    };
    final jsonString = json.encode(body);
    final uri = Uri.parse('http://theslipe.myddns.me:8080/stations');
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + global?["token"]
    };
    final call = await http.post(uri, headers: headers, body: jsonString);

    var res;
    if (call.statusCode == 401) {
      var global = await GlobalData().getGlobal();
      var r = json.decode(
          await LoginData().login(global?["username"], global?["password"]));

      GlobalData().saveLogin(
          r["username"], r["email"], r["token"], global?["password"], true);

      var secondcall = await http.post(uri, headers: headers, body: jsonString);

      res = secondcall.body;
    } else {
      res = call.body;
    }

    return res;
  }

  Future<String> getCarburants(String id) async {
    var url = Uri.parse(
        'http://theslipe.myddns.me:8080/stations/' + id + '/carburants');
    var carburants = await http.get(url);

    return carburants.body;
  }

  Future<String> updateCarburant(List<TextEditingController> listeController,
      String id, List<bool> listeValueDispo) async {
    var carburants =
        await StationsCarburantsViewModel().getStationCarburant(id) as List;
    var index = 0;
    var listeCarburantName = [];
    var listeCarburantDetails = [];
    for (var i in carburants) {
      listeCarburantName.add(carburants[index]['nom']);
      listeCarburantDetails.add({
        "nom": carburants[index]['nom'],
        "codeEuropeen": carburants[index]['code'],
        "disponible":
            listeController[index].text == 0 ? false : listeValueDispo[index],
        "prix":
            listeController[index].text != "" ? listeController[index].text : 0
      });
      index++;
    }

    var global = await GlobalData().getGlobal();
    final body = {
      "listeCarburants": listeCarburantName,
      "details": listeCarburantDetails
    };
    final jsonString = json.encode(body);
    final uri = Uri.parse(
        'http://theslipe.myddns.me:8080/stations/' + id + '/carburants');
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + global?["token"]
    };
    final response = await http.post(uri, headers: headers, body: jsonString);
    return response.body;
  }
}
