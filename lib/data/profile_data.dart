import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tu_carbure/data/global_data.dart';

import 'login_data.dart';

class ProfileData {
  Future<String> getProfile() async {
    var global = await GlobalData().getGlobal();
    var url =
        Uri.parse('http://theslipe.myddns.me:8080/user/' + global?["username"]);

    var profile = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + global?["token"]
    });
    return profile.body;
  }

  Future<String> updateProfile(nom, prenom) async {
    var global = await GlobalData().getGlobal();
    final uri =
        Uri.parse('http://theslipe.myddns.me:8080/user/' + global?["username"]);
    var res;
    var call = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + global?["token"]
        },
        body: json.encode({"nom": nom, "prenom": prenom}));

    if (call.statusCode == 401) {
      var global = await GlobalData().getGlobal();
      var r = json.decode(
          await LoginData().login(global?["username"], global?["password"]));

      GlobalData().saveLogin(
          r["username"], r["email"], r["token"], global?["password"], true);

      var secondcall = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + global?["token"]
          },
          body: json.encode({"nom": nom, "prenom": prenom}));

      res = secondcall.body;
    } else {
      res = call.body;
    }

    return res;
  }
}
