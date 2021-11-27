import 'package:e_diary_mobile/messages/widgets/outbox_message.dart';
import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
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

  Container inboxMessagesListView(BuildContext context, List<Message> messages) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar("Outbox"),
        body: ListView.separated(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.message,color: Colors.white, size: 30.0),
              trailing: const Icon(Icons.keyboard_arrow_right,color: Colors.white),
              title: _title('${messages[index].title}',
                  const TextStyle(fontSize: 15.0,color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'To: ${messages[index].readersName} \nSent: ${messages[index].simpleDateFormat}',
                  style: TextStyle(color: Colors.white)
              ),
              dense: true,
              onTap: () => {
                Navigator.push(
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
