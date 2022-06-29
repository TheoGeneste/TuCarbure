import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RegisterData{

   Future<String> register(String email, String password, String fullname) async {
    final body = {
      "email": email,
      "password": password,
      "fullname": fullname,
      "enabled": true,
    };
    final jsonString = json.encode(body);
    print(jsonString);
    final uri = Uri.parse('http://theslipe.myddns.me:8080/auth/register');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.post(uri, headers: headers, body: jsonString);
    print(response.body);
    return response.body;
  }
}
