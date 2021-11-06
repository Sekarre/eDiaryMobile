import 'dart:convert';
import 'dart:io';

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

import '../../URI.dart';

Future<List<User>> getAllUsers() async {

  String jwt = await jwtOrEmpty;

  Response response = await http.get(SERVER_USER, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return (jsonDecode(response.body) as List)
      .map((data) => User.fromJson(data))
      .toList();
}