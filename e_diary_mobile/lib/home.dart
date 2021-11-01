import 'dart:io';

import 'package:e_diary_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'auth.dart';

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

Future<String> getData() async {

  String jwt = await jwtOrEmpty;

  return http.read(SERVER_DATA_TEST,
      headers: {HttpHeaders.authorizationHeader: jwt}
  );
}