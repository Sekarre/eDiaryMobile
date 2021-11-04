import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../main.dart';
import '../navbar/nav_drawer.dart';
import 'inbox.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Messages"),
        actions: <Widget>[],
      ),
      body: FutureBuilder<String>(
        future: rolesOrEmpty,
        builder: (context, snapshot) {
          return const MessagesWidget();
        },
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
