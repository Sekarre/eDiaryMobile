import 'dart:convert';
import 'dart:io';

import 'package:e_diary_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'URI.dart';
import 'auth/auth.dart';

class HomePage extends StatelessWidget {

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
            title: Text("Test"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                storage.delete(key: "jwt");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp()),
                );
              },
              child: Text("Logout"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) =>
              snapshot.hasData ?
              Column(children: <Widget>[
                Text(snapshot.data.toString(), style: Theme.of(context).textTheme.headline4)
              ],)
                  :
              snapshot.hasError ? Text("An error occurred") : CircularProgressIndicator()
          )
        ),
      );
}

Future<User> getData() async {

  String jwt = await jwtOrEmpty;

  Response res = await http.get(SERVER_USER_PROFILE, headers: {HttpHeaders.authorizationHeader: jwt});
  return User.fromJson(jsonDecode(res.body));

}

class User {
  String name;
  int messageNumber;
  String username;

  User(this.name,
      this.messageNumber,
      this.username);

  User.fromJson(Map<String, dynamic> json):
        name = json['name'],
        messageNumber = json['messageNumber'],
        username = json['username'];

  @override
  String toString() {
    return 'User{name: $name, messageNumber: $messageNumber, username: $username}';
  }
}