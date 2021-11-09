import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth/auth.dart';
import 'home/home.dart';
import 'auth/login.dart';

final storage = FlutterSecureStorage();

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eDiary',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return CircularProgressIndicator();
            if(snapshot.data != "") {
              return HomePage();
            } else {
              return LoginPage();
            }
          }
      ),
    );
  }
}