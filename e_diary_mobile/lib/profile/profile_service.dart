import 'dart:convert';
import 'dart:io';

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:http/http.dart';

import '../URI.dart';
import 'package:http/http.dart' as http;

Future<User> getProfile() async {

  String jwt = await jwtOrEmpty;

  Response res = await http.get(SERVER_USER_PROFILE, headers: {HttpHeaders.authorizationHeader: jwt});
  return User.fromJson(jsonDecode(res.body));
}