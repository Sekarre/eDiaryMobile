import 'dart:io';

import 'package:e_diary_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

class HomePage extends StatelessWidget {

  final storage = FlutterSecureStorage();

  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) =>
      HomePage(
          jwt,
          json.decode(
              ascii.decode(
                  base64.decode(base64.normalize(jwt.split(".")[1]))
              )
          )
      );

  final String jwt;
  final Map<String, dynamic> payload;

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
              future: http.read(SERVER_DATA_TEST,
                  headers: {HttpHeaders.authorizationHeader: 'Bearer $jwt'}
                  ),
              builder: (context, snapshot) =>
              snapshot.hasData ?
              Column(children: <Widget>[
                Text("${payload['password']}, here's the data:"),
                Text(snapshot.data.toString(), style: Theme.of(context).textTheme.headline4)
              ],)
                  :
              snapshot.hasError ? Text("An error occurred") : CircularProgressIndicator()
          )
        ),
      );
}