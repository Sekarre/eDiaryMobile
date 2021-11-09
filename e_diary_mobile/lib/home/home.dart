import 'package:e_diary_mobile/messages/widgets/message_home.dart';
import 'package:e_diary_mobile/notices/widgets/notice_home.dart';
import 'package:e_diary_mobile/reports/widgets/teacher_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../auth/auth.dart';
import '../main.dart';
import '../model/role_type.dart';
import '../navbar/nav_drawer.dart';

class HomePage extends StatelessWidget {

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Main"),
        actions: <Widget>[
        ],
      ),
      body: FutureBuilder<String>(
        future: rolesOrEmpty,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (hasRole( RoleType.ROLE_HEADMASTER, snapshot.data.toString())) {
              return HeadmasterMenuWidget();
            }
            if (hasRole(RoleType.ROLE_DEPUTY_HEAD, snapshot.data.toString())) {
              return DeputyMenuWidget();
            }
            return UserMenuWidget();
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Text("If no data");
        },
      ),
    );
  }

}

bool hasRole(RoleType roleType, String roles) {
  return roles.toString().contains(roleType.formattedToString());
}

class UserMenuWidget extends StatelessWidget {
  const UserMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        // user
        message(context),
        notice(context),
      ],
    );
  }
}

class DeputyMenuWidget extends StatelessWidget {
  const DeputyMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        // user
        message(context),
        notice(context),
        // deputy
        createClass(context),
        manageClass(context),
      ],
    );
  }
}

class HeadmasterMenuWidget extends StatelessWidget {
  const HeadmasterMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        // user
        message(context),
        notice(context),
        // deputy
        createClass(context),
        manageClass(context),
        // headmaster
        teacherReport(context),
        closeYear(context),
        lastYear(context),
      ],
    );
  }
}

Widget message(BuildContext context) {
  return InkWell(
    splashColor: Colors.amber,
    onTap: () => {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MessageHomeWidget()),
      ),
    },
    child: Card(
      color: Colors.amber,
      child: Container(
        height: 200,
        width: 200,
        child: const Center(
          child: Text(
            'Messages',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget notice(BuildContext context) {
  return InkWell(
    splashColor: Colors.amber,
    onTap: () => {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NoticeHome()),
      ),
    },
    child: Card(
      color: Colors.amber,
      child: Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text(
            'Notice',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget createClass(BuildContext context) {
  return InkWell(
    splashColor: Colors.deepPurple,
    onTap: () => null,
    child: Card(
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text(
            'Create class',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget manageClass(BuildContext context) {
  return InkWell(
    splashColor: Colors.deepPurple,
    onTap: () => null,
    child: Card(
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text(
            'Manage class',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget teacherReport(BuildContext context) {
  return InkWell(
    splashColor: Colors.deepPurple,
    onTap: () => {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TeacherReportWidget()),
      ),
    },
    child: Card(
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text(
            'Teacher report',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget closeYear(BuildContext context) {
  return InkWell(
    splashColor: Colors.deepPurple,
    onTap: () => null,
    child: Card(
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text(
            'Close year',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget lastYear(BuildContext context) {
  return InkWell(
    splashColor: Colors.deepPurple,
    onTap: () => null,
    child: Card(
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text(
            'Last year',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}




