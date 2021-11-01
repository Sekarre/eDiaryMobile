import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Uri SERVER_IP = Uri.parse('http://10.0.2.2:8080');
Uri SERVER_LOGIN = Uri.parse("$SERVER_IP/api/auth/signin");
Uri SERVER_DATA_TEST = Uri.parse("$SERVER_IP/api/wallet/password/1");

final storage = FlutterSecureStorage();

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: "jwt");
  if(jwt == null)
    return "";
  return jwt;
}

class User {
  final String token;
  final String username;
  final String email;

  User(this.token, this.username, this.email);

  User.fromJson(Map<String, dynamic> json):
        token = json['token'],
        username = json['username'],
        email = json['email'];
}