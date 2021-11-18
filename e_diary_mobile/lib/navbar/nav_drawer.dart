import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/home/home.dart';
import 'package:e_diary_mobile/messages/widgets/message_home.dart';
import 'package:e_diary_mobile/model/role_type.dart';
import 'package:e_diary_mobile/notices/widgets/notice_home.dart';
import 'package:e_diary_mobile/notices/widgets/notices.dart';
import 'package:e_diary_mobile/profile/profile.dart';
import 'package:e_diary_mobile/reports/widgets/teacher_report.dart';
import 'package:e_diary_mobile/schoolyears/widgets/past_school_years.dart';
import 'package:e_diary_mobile/schoolyears/widgets/school_year_close.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
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
      child: new Container(
        color: Color(0xFFF3E5F5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
              height: 200,
              child: new DrawerHeader(
                child: Text(
                  'User',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                decoration: buildBoxDecoration(),
              ),
            ),
            homeTile(context),
            profileTile(context),
            messagesTile(context),
            noticesTile(context),
            logoutTile(context),
          ],
        ),
      ),
    );
  }

  Drawer drawDeputyHeadSidebar(BuildContext context) {
    return Drawer(
      child: new Container(
        color: Color(0xFFF3E5F5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
              height: 200,
              child: new DrawerHeader(
                child: Text(
                  'Deputy Head',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                decoration: buildBoxDecoration(),
              ),
            ),
            homeTile(context),
            profileTile(context),
            messagesTile(context),
            noticesHomeTile(context),
            createClassTile(context),
            manageClassTile(context),
            logoutTile(context),
          ],
        ),
      ),
    );
  }

  Drawer drawHeadmasterSidebar(BuildContext context) {
    return Drawer(
      child: new Container(
        color: Color(0xFFF3E5F5),
        child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new Container(
            height: 200,
            child: new DrawerHeader(
              child: Text(
                'Headmaster',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: buildBoxDecoration(),
            ),
          ),
          homeTile(context),
          profileTile(context),
          messagesTile(context),
          noticesHomeTile(context),
          createClassTile(context),
          manageClassTile(context),
          teacherReportTile(context),
          closeYearTile(context),
          lastYearTile(context),
          logoutTile(context),
        ],
      ),
      ),
    );
  }

  ListTile homeTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('Home'),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()
            )
        )
      },
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
          MaterialPageRoute(builder: (context) => const MessageHomeWidget()),
        ),
      },
    );
  }

  ListTile noticesHomeTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle_notifications),
      title: Text('Notices'),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NoticeHome()),
        ),
      },
    );
  }

  ListTile noticesTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle_notifications),
      title: Text('Notices'),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NoticesWidget()),
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
      leading: Icon(Icons.picture_as_pdf),
      title: Text('Teacher report'),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TeacherReportWidget()),
        ),
      },
    );
  }

  ListTile closeYearTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.assignment_late_outlined),
      title: Text('Close school year'),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SchoolYearCloseWidget()),
        ),
      },
    );
  }

  ListTile lastYearTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Last years archive'),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PastSchoolYearsWidget()),
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
