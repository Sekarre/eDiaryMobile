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
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewMessageWidget()
          )
      )
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
                    "New Message",
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

Widget outbox(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const OutboxWidget()
          )
      )
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
                    "Outbox",
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

Widget inbox(BuildContext context) {
  return InkWell(
    splashColor: Color(0xFF2E7D32),
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InboxWidget()
          )
      )
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
                    "Inbox",
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

