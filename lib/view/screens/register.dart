import 'package:flutter/material.dart';

import '../../data/register_data.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  _register() {
    if (usernameController.text != "" &&
        mailController.text != "" &&
        passwordConfirmationController.text != "" &&
        passwordController.text != "") {
      if (passwordController.text == passwordConfirmationController.text) {
        RegisterData().register(mailController.text,
            passwordController.text, usernameController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Text("Inscription", style: TextStyle(fontSize: 30)),
      ),
      Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nom d\'utilisateur',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextFormField(
                controller: mailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Mail',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Mot de passe',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextFormField(
                controller: passwordConfirmationController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Confirmation du mot de passe',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  _register();
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
    ])));
  }
}
