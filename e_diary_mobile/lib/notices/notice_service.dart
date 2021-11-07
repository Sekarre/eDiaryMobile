import 'dart:convert';
import 'dart:io';

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/notice.dart';
import 'package:http/http.dart';

import '../URI.dart';
import 'package:http/http.dart' as http;

Future<List<Notice>> getNotices() async {
  String jwt = await jwtOrEmpty;

  Response response = await http.get(SERVER_USER_NOTICES, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return (jsonDecode(response.body) as List)
      .map((data) => Notice.fromJson(data))
      .toList();
}