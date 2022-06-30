import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefUtils {

  static addToFav(Map<String, String> fav) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('fav') == false){
      print("oui");
      prefs.setString('fav', "[]");
    }

    List<dynamic> list = json.decode(prefs.get('fav').toString());

    bool add = true;
    list.forEach((element) {

      if(element["id"] == fav["id"]){
        add = false;
      }
    });

    if(add){
      list.add(fav);
    }
    
    String encodedMap = json.encode(list);
    prefs.setString('fav', encodedMap);

  }

  static Future<List> getFav() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('fav') == false){
      print("oui");
      prefs.setString('fav', "[]");
    }

    List<dynamic> list = json.decode(prefs.get('fav').toString());

    return list;

  }

  static removeFav(id) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> res = json.decode(prefs.get('fav').toString());

    var toRemove;
    res.forEach((element) {
      if(element["id"] == id){
        toRemove = element;
      }
    });
    res.remove(toRemove);

    String encodedMap = json.encode(res);
    prefs.setString('fav', encodedMap);

  }

}