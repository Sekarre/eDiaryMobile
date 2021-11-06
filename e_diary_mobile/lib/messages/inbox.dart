import 'package:e_diary_mobile/messages/message_home.dart';
import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/model/message_status.dart';
import 'package:e_diary_mobile/shared/no_data.dart';
import 'package:flutter/material.dart';

import 'message_service.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getInboxMessages(),
        builder: (context, AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.hasData) {
            return inboxMessagesListView(context, snapshot.requireData);
          } else {
            return NoDataPage();
          }
        });
  }

  Scaffold inboxMessagesListView(BuildContext context, List<Message> messages) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox"),
        actions: const <Widget>[],
      ),
      body: ListView.separated(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.message, size: 30.0),
            trailing: const Icon(Icons.keyboard_arrow_right),
            title: _title('${messages[index].title}',
                const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            selected: messages[index].status ==
                MessageStatus.SENT.formattedToString(),
            subtitle: Text(
                'Od: ${messages[index].sendersName} \nOdebrano: ${messages[index].simpleDateFormat}'),
            dense: true,
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MessagesPage()),
              ),
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _title(String text, TextStyle style) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
