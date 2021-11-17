import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../main.dart';
import '../navbar/nav_drawer.dart';
import 'inbox.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
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
          stops: [0.1, 0.3, 0.5, 0.9],
        ),
      ),
      child: Scaffold(
      backgroundColor: Colors.transparent,
      drawer: NavDrawer(),
      appBar: AppBar(
          title: Text("Messages"),
          actions: <Widget>[],
          backgroundColor: Color(0xFFAB47BC),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25.0),
              )
          )
      ),
      body: FutureBuilder<String>(
        future: rolesOrEmpty,
        builder: (context, snapshot) {
          return const MessagesWidget();
        },
      ),
      ),
    );
  }
}

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({
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
      children: <Widget>[inbox(context), outbox(context), sendMessage(context)],
    );
  }
}

Widget sendMessage(BuildContext context) {
  return InkWell(
    splashColor: Colors.deepPurple,
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp()
          )
      )
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
            'Send messages',
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

Widget outbox(BuildContext context) {
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
            'Outbox',
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

Widget inbox(BuildContext context) {
  return InkWell(
    splashColor: Colors.deepPurple,
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InboxPage()
          )
      )
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
            'Inbox',
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
