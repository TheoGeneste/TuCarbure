import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfileData{

   Future<String> getProfile(String username) async {
    var url = Uri.parse('http://theslipe.myddns.me:8080/user/' + username);
    var profile = await http.get(url);
    print(profile.body);
    return profile.body;
  }
}
