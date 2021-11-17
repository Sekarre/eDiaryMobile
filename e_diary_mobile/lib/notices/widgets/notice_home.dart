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
            'Notices',
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
            'Add notice',
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