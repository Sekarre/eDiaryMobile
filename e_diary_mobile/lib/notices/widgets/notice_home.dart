import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/navbar/nav_drawer.dart';
import 'package:e_diary_mobile/notices/widgets/notices.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:flutter/material.dart';

import 'new_notice.dart';

class NoticeHome extends StatelessWidget {
  const NoticeHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
      drawer: NavDrawer(),
      appBar: buildAppBar("Notices"),
      body: FutureBuilder<String>(
        future: rolesOrEmpty,
        builder: (context, snapshot) {
          return const NoticeWidget();
        },
      ),
    ),
    );
  }
}

class NoticeWidget extends StatelessWidget {
  const NoticeWidget({
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
      children: <Widget>[listNotices(context), addNotices(context)],
    );
  }
}

Widget listNotices(BuildContext context) {
  return InkWell(
    splashColor: Colors.amber,
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NoticesWidget()
          )
      )
    },
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.transparent,
          width: 2.0,
        ),
      ),
      color: Colors.transparent,
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
                        BorderRadius.circular(100.0)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.verified_user,
                        size: 50,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Notices",
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget addNotices(BuildContext context) {
  return InkWell(
    splashColor: Colors.amber,
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewNoticeWidget()
          )
      )
    },
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
        side: BorderSide(
          color: Colors.transparent,
          width: 2.0,
        ),
      ),
      color: Colors.transparent,
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
                        BorderRadius.circular(100.0)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.verified_user,
                        size: 50,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Add Notice",
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}