import 'package:e_diary_mobile/messages/widgets/new_message.dart';
import 'package:e_diary_mobile/messages/widgets/outbox.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:flutter/material.dart';

import '../../auth/auth.dart';
import '../../main.dart';
import '../../navbar/nav_drawer.dart';
import 'inbox.dart';

class MessageHomeWidget extends StatelessWidget {
  const MessageHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        drawer: NavDrawer(),
        backgroundColor: Colors.transparent,
        appBar: buildAppBar("Messages"),
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
              builder: (context) => NewMessageWidget()
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
            'New message',
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
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const OutboxWidget()
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
              builder: (context) => InboxWidget()
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
