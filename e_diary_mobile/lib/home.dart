import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'URI.dart';
import 'auth/auth.dart';
import 'menu/navDrawer.dart';
import 'model/user.dart';

class HomePage extends StatelessWidget {

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text("Main"),
          actions: <Widget>[
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
