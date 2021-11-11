import 'dart:convert';

import 'package:e_diary_mobile/home/home.dart';
import 'package:e_diary_mobile/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../URI.dart';
import 'auth.dart';

class LoginPage extends StatelessWidget {

  final storage = FlutterSecureStorage();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      return AuthResponse.fromJson(jsonDecode(res.body)).token;
    return null;
  }

  Widget _buildLoginTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Username',
            style: TextStyle(
              fontSize: 20,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFFAB47BC),
              border: Border.all(
                color: Colors.purple,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            height: 60.0,
            child: TextField(
                controller: _usernameController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                )
            ),
          ),
        ]
    );
  }

  Widget _buildPasswordTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Password',
            style: TextStyle(
              fontSize: 20,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFFAB47BC),
              border: Border.all(
                color: Colors.purple,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            height: 60.0,
            child: TextField(
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                )
            ),
          ),
        ]
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8E24AA),
                  Color(0xFFAB47BC),
                  Color(0xFFCE93D8),
                  Color(0xFFF3E5F5),
                ],
                  stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30.0),
                  _buildLoginTF(),
                  SizedBox(height: 30.0),
                  _buildPasswordTF(),
                Container(
                  padding: EdgeInsets.symmetric(vertical:25.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      var jwt = await attemptLogIn(username, password);
                      if(jwt != null) {
                        storage.write(key: "jwt", value: "Bearer $jwt");
                        var user = await getProfile();
                        if (user != null) {
                          storage.write(key: "roles", value: user.roles.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()
                              )
                          );
                        }
                      } else {
                        displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
                      }
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.purple,
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ]
              )
            )
          )
        ]
      ),
    );
  }

}