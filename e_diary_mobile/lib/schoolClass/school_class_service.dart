import 'dart:convert';
import 'dart:io';

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/school_class.dart';
import 'package:e_diary_mobile/model/teacher.dart';
import 'package:http/http.dart';

import '../URI.dart';
import 'package:http/http.dart' as http;

Future<List<Teacher>> getUnassignedTeachers() async {
  String jwt = await jwtOrEmpty;

  Response response = await http.get(SERVER_DEPUTY_UNASSIGNED_TEACHERS, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return (jsonDecode(response.body) as List)
      .map((data) => Teacher.fromJson(data))
      .toList();
}

Future<Response> createClassWithFormTutorAndClassName(SchoolClass schoolClass) async {
  String jwt = await jwtOrEmpty;

  var res = await http.post(
      SERVER_DEPUTY_CREATE_CLASS,
      headers: {
        HttpHeaders.authorizationHeader: jwt,
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: jsonEncode(schoolClass));

  return res;
}