Uri SERVER_IP = Uri.parse('http://10.0.2.2:8085/api/v1');

Uri SERVER_LOGIN = Uri.parse("$SERVER_IP/auth/login");
Uri SERVER_CHANGE_PASSWORD = Uri.parse("$SERVER_IP/auth/password-change");

Uri SERVER_USER = Uri.parse("$SERVER_IP/user");
Uri SERVER_USER_PROFILE = Uri.parse("$SERVER_IP/user/profile");