import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/login_data.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _login() async {
    if (mailController.text != "" && passwordController.text != "") {
      var res = await LoginData().login(mailController.text, passwordController.text);
      var r =  jsonDecode(res) as Map<String,dynamic>;
      var token = r["token"];
      var email = r["email"];
      print(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Center(
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child:Text("Se connecter", style:TextStyle(fontSize: 30)),
                ),
                Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                          child: TextFormField(
                            controller: mailController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                          child: TextFormField(
                            controller : passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Mot de passe',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              _login();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),
                            ),
                            child: const Text('Se connecter'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),
                            ),
                            child: const Text('S\'inscrire'),
                          ),
                        ),
                      ],
                    ),
                ),
              ])
          ));
  }
}
