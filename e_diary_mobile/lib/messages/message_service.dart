import 'dart:convert';
import 'dart:io';

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/message.dart';
import 'package:http/http.dart';

import '../URI.dart';
import 'package:http/http.dart' as http;

Future<List<Message>> getInboxMessages() async {
  String jwt = await jwtOrEmpty;

  Response response = await http.get(SERVER_USER_INBOX, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return (jsonDecode(response.body) as List)
      .map((data) => Message.fromJson(data))
      .toList();
}

Future<List<Message>> getOutboxMessages() async {
  String jwt = await jwtOrEmpty;

  Response response = await http.get(SERVER_USER_OUTBOX, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return (jsonDecode(response.body) as List)
      .map((data) => Message.fromJson(data))
      .toList();
}

Future<bool> sendNewMessage(Message message) async {
  String jwt = await jwtOrEmpty;

  var res = await http.post(
      SERVER_USER_SEND_MESSAGE,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: jwt
      },
      body: jsonEncode(message));

  return res.statusCode == 200;
}

