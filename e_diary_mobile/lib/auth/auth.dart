import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../URI.dart';

final storage = FlutterSecureStorage();

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: "jwt");
  if (jwt == null) return "";
  return jwt;
}

Future<String?> changePassword(String oldPassword, String newPassword) async {

  String jwt = await jwtOrEmpty;

  var res = await http.post(
      SERVER_CHANGE_PASSWORD,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: jwt
      },
      body: jsonEncode(<String, String>{
        "currentPassword": oldPassword,
        "newPassword": newPassword
      })
  );
  if(res.statusCode == 200) {
    String jwt = AuthResponse.fromJson(jsonDecode(res.body)).token;
    storage.write(key: "jwt", value: "Bearer $jwt");
    return 'T';
  }
  return null;
}

Future<String> get rolesOrEmpty async {
  var roles = await storage.read(key: "roles");
  if (roles == null) return "";
  return roles;
}

class AuthResponse {
  final String token;

  AuthResponse(this.token);

  AuthResponse.fromJson(Map<String, dynamic> json) : token = json['token'];
}