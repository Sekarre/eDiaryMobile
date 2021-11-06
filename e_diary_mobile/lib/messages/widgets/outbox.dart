import 'package:e_diary_mobile/messages/widgets/outbox_message.dart';
import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:flutter/material.dart';

import '../message_service.dart';

class OutboxWidget extends StatelessWidget {
  const OutboxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOutboxMessages(),
        builder: (context, AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.hasData) {
            return inboxMessagesListView(context, snapshot.requireData);
          } else {
            return NoDataWidget(NO_MESSAGES);
          }
        });
  }

  Scaffold inboxMessagesListView(BuildContext context, List<Message> messages) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Outbox"),
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
            subtitle: Text(
                'To: ${messages[index].readersName} \nSent: ${messages[index].simpleDateFormat}'),
            dense: true,
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OutboxMessageWidget(messageId: messages[index].id!)),
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
