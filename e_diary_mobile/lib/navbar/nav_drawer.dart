import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/home/home.dart';
import 'package:e_diary_mobile/messages/widgets/message_home.dart';
import 'package:e_diary_mobile/model/role_type.dart';
import 'package:e_diary_mobile/notices/widgets/notice_home.dart';
import 'package:e_diary_mobile/notices/widgets/notices.dart';
import 'package:e_diary_mobile/profile/profile.dart';
import 'package:e_diary_mobile/reports/widgets/teacher_report.dart';
import '../schoolClass/widgets/school_class.dart';
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
        color: Color(0xFF303030),
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
        color: Color(0xFF303030),
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
        color: Color(0xFF303030),
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
      leading: Icon(Icons.home_outlined, color: Colors.white),
      title: Text('Home', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.person_outlined, color: Colors.white),
      title: Text('Profile', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.email_outlined, color: Colors.white),
      title: Text('Messages', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.circle_notifications_outlined, color: Colors.white),
      title: Text('Notices', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.circle_notifications_outlined, color: Colors.white),
      title: Text('Notices', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.article_outlined, color: Colors.white),
      title: Text('Manage class', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.create_outlined, color: Colors.white),
      title: Text('Create class', style: TextStyle(color: Colors.white)),
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SchoolClassWidget()),
        ),
      },
    );
  }

  ListTile teacherReportTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.picture_as_pdf_outlined, color: Colors.white),
      title: Text('Teacher report', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.assignment_late_outlined, color: Colors.white),
      title: Text('Close school year', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.archive_outlined, color: Colors.white),
      title: Text('Last years archive', style: TextStyle(color: Colors.white)),
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
      leading: Icon(Icons.exit_to_app_outlined, color: Colors.white),
      title: Text('Logout', style: TextStyle(color: Colors.white)),
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
