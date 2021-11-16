import 'package:e_diary_mobile/messages/widgets/message_home.dart';
import 'package:e_diary_mobile/notices/widgets/notice_home.dart';
import 'package:e_diary_mobile/reports/widgets/teacher_report.dart';
import 'package:e_diary_mobile/profile/profile.dart';
import 'package:e_diary_mobile/schoolyears/widgets/past_school_years.dart';
import 'package:e_diary_mobile/schoolyears/widgets/school_year_close.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../auth/auth.dart';
import '../model/role_type.dart';
import '../navbar/nav_drawer.dart';

class HomePage extends StatelessWidget {

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
      backgroundColor: Colors.transparent,
      drawer: NavDrawer(),
      appBar: buildAppBar("Home"),
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
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.person), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => ProfilePage()
            )
          );
      },
        backgroundColor: const Color(0xFFAB47BC), hoverElevation: 1.5, elevation: 1.5,
        shape: StadiumBorder(
            side: BorderSide(
                color: Color(0xFF8E24AA), width: 5)), ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
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
      primary: false,
      padding: const EdgeInsets.all(15),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
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
      primary: false,
      padding: const EdgeInsets.all(15),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
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
      primary: false,
      padding: const EdgeInsets.all(15),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.amberAccent,
          width: 2.0,
        ),
      ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.amberAccent,
          width: 2.0,
        ),
      ),
      color: Colors.amber,
      child: Container(
        height: 200,
        width: 200,
        child: const Center(
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2.0,
        ),
      ),
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: const Center(
          child: Text(
            'Create Class',
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2.0,
        ),
      ),
        color: Colors.deepPurple,
        child: Container(
          height: 200,
          width: 200,
          child: const Center(
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TeacherReportWidget()),
      ),
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2.0,
        ),
      ),
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: const Center(
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
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SchoolYearCloseWidget()),
      ),
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2.0,
        ),
      ),
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: const Center(
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
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PastSchoolYearsWidget()),
      ),
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2.0,
        ),
      ),
      color: Colors.deepPurple,
      child: Container(
        height: 200,
        width: 200,
        child: const Center(
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




