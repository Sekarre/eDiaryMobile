import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: "jwt");
  if (jwt == null) return "";
  return jwt;
}

Future<String> get rolesOrEmpty async {
  var roles = await storage.read(key: "roles");
  if (roles == null) return "";
  return roles;
}

class AuthResponse {
  final String token;

  AuthResponse(this.token);

  AuthResponse.fromJson(Map<String, dynamic> json) : token = json['token'];
}