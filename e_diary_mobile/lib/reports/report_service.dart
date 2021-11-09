import 'dart:convert';
import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/report_request.dart';
import 'package:e_diary_mobile/model/teacher.dart';
import 'package:e_diary_mobile/shared/randomize_util.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import '../../URI.dart';

Future<List<Teacher>> getAllTeachers() async {

  String jwt = await jwtOrEmpty;

  var response = await http.get(SERVER_HEADMASTER_TEACHER, headers: {
    HttpHeaders.authorizationHeader: jwt,
    HttpHeaders.acceptHeader: 'application/json; charset=UTF-8'
  });

  return (jsonDecode(response.body) as List)
      .map((data) => Teacher.fromJson(data))
      .toList();
}

Future<String?> generateTeachersReport(ReportRequest reportRequest) async {
  String jwt = await jwtOrEmpty;

  var res = await http.post(
      SERVER_HEADMASTER_TEACHER_REPORT,
      headers: {
        HttpHeaders.authorizationHeader: jwt,
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: jsonEncode(reportRequest));

  if (res.statusCode != 200) {
    return null;
  }

  final dir = await _getDownloadDirectory();
  final isPermissionStatusGranted = await _requestPermissions();

  if (isPermissionStatusGranted) {
    String filename = res.body.startsWith("%PDF") ? (getRandomString(7) + ".pdf") : (getRandomString(7) + ".zip");

    final savePath = path.join(dir!.path, filename);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);

    await file.writeAsBytes(res.bodyBytes, flush: true);
    await raf.close();
    return dir.path;
  }

  return null;
}


Future<Directory?> _getDownloadDirectory() async {
  if (Platform.isAndroid) {
    return await DownloadsPathProvider.downloadsDirectory;
  }

  return await getApplicationDocumentsDirectory();
}

Future<bool> _requestPermissions() async {

  var permission = await Permission.storage.status.isGranted;

  if (!permission) {
    await Permission.storage.request();
    permission = await Permission.storage.status.isGranted;
  }

  return permission;
}