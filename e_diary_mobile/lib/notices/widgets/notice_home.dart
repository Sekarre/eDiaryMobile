import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/navbar/nav_drawer.dart';
import 'package:e_diary_mobile/notices/widgets/notices.dart';
import 'package:flutter/material.dart';

class NoticeHome extends StatelessWidget {
  const NoticeHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Notices"),
        actions: <Widget>[],
      ),
      body: FutureBuilder<String>(
        future: rolesOrEmpty,
        builder: (context, snapshot) {
          return const NoticeWidget();
        },
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
      crossAxisCount: 2,
      children: <Widget>[listNotices(context)],
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