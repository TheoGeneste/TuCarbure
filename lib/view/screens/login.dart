import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tu_carbure/view/screens/register.dart';

import '../../data/global_data.dart';
import '../../data/login_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (mailController.text != "" && passwordController.text != "") {
      var res = await LoginData().login(
          mailController.text, passwordController.text);
      var r = jsonDecode(res) as Map<String, dynamic>;

      SharedPreferences.setMockInitialValues({});
      //Si se souvenir de moi alors :
      //test@gmail.com:password : Test123
      GlobalData().saveLogin(r["username"],r["email"],r["token"]);
    }
  }




  @override
  Widget build(BuildContext context) {
    var seSouvenirDeMoi = false;
    return SingleChildScrollView(
        child: Center(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Text("Se connecter", style: TextStyle(fontSize: 30)),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: TextFormField(
                        controller: mailController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Mot de passe',
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        child: CheckboxListTile(
                          value: seSouvenirDeMoi = false,
                          title: Text("Se souvenir de moi"),
                          onChanged: (bool? value) {
                            seSouvenirDeMoi = !seSouvenirDeMoi;
                            print(seSouvenirDeMoi);
                          },

                        )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
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
                          Navigator.pushNamed(context, Register.routeNames);
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
        )
    );
  }

}
