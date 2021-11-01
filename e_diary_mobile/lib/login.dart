import 'dart:convert';

import 'package:e_diary_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? JWT = null;


  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

  Future<String?> attemptLogIn(String username, String password) async {
    var res = await http.post(
        SERVER_LOGIN,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": username,
          "password": password
        })
    );
    if(res.statusCode == 200)
      return User.fromJson(jsonDecode(res.body)).token;
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log In"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Username'
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
              ),
              FlatButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    JWT = await attemptLogIn(username, password);
                    if(JWT != null) {
                      storage.write(key: "jwt", value: JWT);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage.fromBase64(JWT!)
                          )
                      );
                    } else {
                      displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
                    }
                  },
                  child: Text("Log In")
              )
            ],
          ),
        )
    );
  }
}

class User {
  final String token;
  final String username;
  final String email;

  User(this.token, this.username, this.email);

  User.fromJson(Map<String, dynamic> json):
        token = json['token'],
        username = json['username'],
        email = json['email'];
}