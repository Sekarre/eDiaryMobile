import 'dart:convert';
import 'dart:io';

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/school_class.dart';
import 'package:e_diary_mobile/model/student.dart';
import 'package:e_diary_mobile/model/teacher.dart';
import 'package:http/http.dart';

import '../URI.dart';
import 'package:http/http.dart' as http;

Future<List<SchoolClass>> getSchoolClasses() async {
  String jwt = await jwtOrEmpty;

  Response response = await http.get(SERVER_DEPUTY_CLASS_MANAGEMENT, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return (jsonDecode(response.body) as List)
      .map((data) => SchoolClass.fromJson(data))
      .toList();
}

Future<SchoolClass> getClassView(int id) async {
  String jwt = await jwtOrEmpty;

  Response response = await http.get(Uri.parse("$SERVER_DEPUTY_CLASS_VIEW/$id"), headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return SchoolClass.fromJson(jsonDecode(response.body));
}

Future<bool> deleteSchoolClass(SchoolClass schoolClass) async {
  String jwt = await jwtOrEmpty;
  String uri = SERVER_DEPUTY_DELETE_CLASS.toString() + "/" + schoolClass.id.toString();

  var res = await http.delete(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: jwt
      },
      body: jsonEncode(schoolClass));

  return res.statusCode == 200;
}

Future<bool> deleteStudentFromClass(Student student, int schoolClassId) async {
  String jwt = await jwtOrEmpty;
  String uri = SERVER_DEPUTY_DELETE_CLASS.toString() + "/" + schoolClassId.toString() + "/student-remove/"
      + student.id.toString();

  var res = await http.delete(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: jwt
      },
      body: jsonEncode(student));

  return res.statusCode == 200;
}

Future<List<Student>> getUnassignedStudents() async {
  String jwt = await jwtOrEmpty;

  Response response = await http.get(SERVER_DEPUTY_UNASSIGNED_STUDENTS, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });


  return (jsonDecode(response.body) as List)
      .map((data) => Student.fromJson(data))
      .toList();
}

Future<bool> addStudentToClass(Student student, int schoolClassId) async {
  String jwt = await jwtOrEmpty;
  String uri = SERVER_DEPUTY_ADD_STUDENT.toString() + "/" + schoolClassId.toString() + "/student-add/"
      + student.id.toString();

  var res = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: jwt
      },
      body: jsonEncode(student));

  return res.statusCode == 200;
}

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

Future<bool> changeClassFormTutor(Teacher teacher, int schoolClassId) async {
  String jwt = await jwtOrEmpty;
  String uri = SERVER_DEPUTY_CHANGE_TEACHER.toString() + "/" + schoolClassId.toString() + "/teacher-add/"
      + teacher.id.toString();

  var res = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: jwt
      },
      body: jsonEncode(teacher));

  return res.statusCode == 200;
}


