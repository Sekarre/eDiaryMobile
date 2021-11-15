import 'dart:io';

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

import '../../URI.dart';

Future<bool> closeYear() async {

  String jwt = await jwtOrEmpty;

  Response response = await http.post(SERVER_HEADMASTER_CLOSE_YEAR, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return response.statusCode == 200;
}