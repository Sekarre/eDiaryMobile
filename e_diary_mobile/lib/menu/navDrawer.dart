import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../main.dart';

class NavDrawer extends StatelessWidget {

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
            )
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
    logout(),
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(
    builder: (context) => MyApp()),
    ),
    },
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    storage.delete(key: "jwt");
  }
}