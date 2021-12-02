import 'package:e_diary_mobile/messages/widgets/message_home.dart';
import 'package:e_diary_mobile/notices/widgets/notice_home.dart';
import 'package:e_diary_mobile/notices/widgets/notices.dart';
import 'package:e_diary_mobile/reports/widgets/teacher_report.dart';
import 'package:e_diary_mobile/profile/profile.dart';
import '../schoolClass/widgets/school_class.dart';
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
      FloatingActionButton(child: Icon(Icons.person, color: Colors.white,), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => ProfilePage()
            )
          );
      },
        backgroundColor: const Color(0xFF303030), hoverElevation: 1.5, elevation: 1.5,
        shape: StadiumBorder(
            side: BorderSide(
                color: Color(0xFF212121), width: 5)), ),
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
        noticeHome(context),
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
        noticeHome(context),
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
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MessageHomeWidget()),
      ),
    },
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30.0)),
                  elevation: 5,
                  color: Color(0xFF424242),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.email,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Messages",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget noticeHome(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NoticeHome()),
      ),
    },
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30.0)),
                  elevation: 5,
                  color: Color(0xFF424242),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.circle_notifications,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Notice",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget notice(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NoticesWidget()),
      ),
    },
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30.0)),
                  elevation: 5,
                  color: Color(0xFF424242),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.verified_user,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Notice",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget createClass(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SchoolClassWidget()),
      ),
    },
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30.0)),
                  elevation: 5,
                  color: Color(0xFF424242),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.create,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Create Class",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget manageClass(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => null,
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30.0)),
                  elevation: 5,
                  color: Color(0xFF424242),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.article,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Manage Class",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget teacherReport(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TeacherReportWidget()),
      ),
    },
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30.0)),
                  elevation: 5,
                  color: Color(0xFF424242),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Teacher Report",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget closeYear(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SchoolYearCloseWidget()),
      ),
    },
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30.0)),
                  elevation: 5,
                  color: Color(0xFF424242),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.assignment_late,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Close Year",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget lastYear(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PastSchoolYearsWidget()),
      ),
    },
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30.0)),
                  elevation: 5,
                  color: Color(0xFF424242),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.verified_user,
                      size: 50,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Last Year",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}




