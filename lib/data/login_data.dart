import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class LoginData{

   Future<String> login(String email, String password) async {
    final body = {
      "email": email,
      "password": password,
    };
    final jsonString = json.encode(body);
    final uri = Uri.parse('http://theslipe.myddns.me:8080/auth/login');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.post(uri, headers: headers, body: jsonString);
    return response.body;
  }
}
