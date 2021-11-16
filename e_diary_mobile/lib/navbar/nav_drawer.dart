

import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/messages/message_home.dart';
import 'package:e_diary_mobile/model/role_type.dart';
import 'package:e_diary_mobile/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../main.dart';

class NavDrawer extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FutureBuilder(
            future: rolesOrEmpty,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (hasRole(
                    RoleType.ROLE_HEADMASTER, snapshot.data.toString())) {
                  return drawHeadmasterSidebar(context);
                }
                if (hasRole(
                    RoleType.ROLE_DEPUTY_HEAD, snapshot.data.toString())) {
                  return drawDeputyHeadSidebar(context);
                }
                return drawDefaultSidebar(context);
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  Drawer drawDefaultSidebar(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new Container(
            height: 200,
            child: new DrawerHeader(
                child: Text(
                  'User',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF8E24AA),
                      Color(0xFFAB47BC),
                      Color(0xFFCE93D8),
                      Color(0xFFF3E5F5),
                    ],
                    stops: [0.1, 0.5, 0.9, 1.0],
                  ),
                )),),
          new Container(
            height: 480,
            color: Color(0xFFF3E5F5),
            child: new Column(
              children: <Widget> [
                profileTile(context),
                messagesTile(context),
                logoutTile(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawDeputyHeadSidebar(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new Container(
            height: 200,
            child: new DrawerHeader(
                child: Text(
                  'Deputy Head',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF8E24AA),
                      Color(0xFFAB47BC),
                      Color(0xFFCE93D8),
                      Color(0xFFF3E5F5),
                    ],
                    stops: [0.1, 0.5, 0.9, 1.0],
                  ),
                )),),
          new Container(
            height: 480,
            color: Color(0xFFF3E5F5),
            child: new Column(
              children: <Widget> [
                profileTile(context),
                messagesTile(context),
                createClassTile(context),
                manageClassTile(context),
                logoutTile(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawHeadmasterSidebar(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new Container(
            height: 200,
            child: new DrawerHeader(
              child: Text(
                'Headmaster',
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF8E24AA),
                    Color(0xFFAB47BC),
                    Color(0xFFCE93D8),
                    Color(0xFFF3E5F5),
                  ],
                  stops: [0.1, 0.5, 0.9, 1.0],
                ),
              )),),
            new Container(
              height: 480,
              color: Color(0xFFF3E5F5),
              child: new Column(
                children: <Widget> [
                  profileTile(context),
                  createClassTile(context),
                  manageClassTile(context),
                  teacherReportTile(context),
                  closeYearTile(context),
                  lastYearTile(context),
                  logoutTile(context),
                ],
              ),
            ),
        ],
      ),
    );
  }

  ListTile profileTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.verified_user),
      title: Text('Profile'),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage()
            )
        )
      },
    );
  }

  ListTile messagesTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Messages'),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MessagesPage()),
        ),
      },
    );
  }

  ListTile manageClassTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Manage class'),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        ),
      },
    );
  }

  ListTile createClassTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Create class'),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        ),
      },
    );
  }

  ListTile teacherReportTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Teacher report'),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        ),
      },
    );
  }

  ListTile closeYearTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Close school year'),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        ),
      },
    );
  }

  ListTile lastYearTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Last years archive'),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        ),
      },
    );
  }

  ListTile logoutTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Logout'),
      onTap: () => {
        logout(),
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        ),
      },
    );
  }

  Future<void> logout() async {
    storage.delete(key: "jwt");
  }

  Future<String> setRoles() async {
    return rolesOrEmpty.toString();
  }

  bool hasRole(RoleType roleType, String roles) {
    return roles.toString().contains(roleType.formattedToString());
  }
}
