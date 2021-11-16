import 'dart:convert';
import 'dart:io';

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/end_year_report.dart';
import 'package:e_diary_mobile/model/report_type.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

import '../../URI.dart';

Future<bool> closeSchoolYear() async {

  String jwt = await jwtOrEmpty;

  Response response = await http.post(SERVER_HEADMASTER_CLOSE_YEAR, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return response.statusCode == 200;
}

Future<List<EndYearReport>> getPastSchoolYearsReports(ReportType reportType, int year) async {

  String jwt = await jwtOrEmpty;
  var uri = ReportType.STUDENT == reportType ? SERVER_HEADMASTER_PAST_YEARS_REPORTS_STUDENTS : SERVER_HEADMASTER_PAST_YEARS_REPORTS_TEACHERS;
  var uriWithParams = Uri.parse(uri.toString() + "?year=" + year.toString());

  Response response = await http.get(uriWithParams, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return (jsonDecode(response.body) as List)
      .map((data) => EndYearReport.fromJson(data))
      .toList();
}

Future<List<String>> getAllReportsYears() async {

  String jwt = await jwtOrEmpty;

  Response response = await http.get(SERVER_HEADMASTER_PAST_YEARS, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return new List<String>.from(jsonDecode(response.body));
}