import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:flutter/material.dart';

import '../message_service.dart';
import 'new_message.dart';

class InboxMessageWidget extends StatelessWidget {

  var _titleController = TextEditingController();
  var _contentController = TextEditingController();
  var _senderController = TextEditingController();

  final int messageId;

  InboxMessageWidget({Key? key, required this.messageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getInboxSingleMessage(messageId),
        builder: (context, AsyncSnapshot<Message> snapshot) {
          if (snapshot.hasData) {
            setControllers(snapshot);
            return inboxMessagesListView(context, snapshot.requireData);
          } else {
            return NoDataWidget(NO_DATA_FOUND);
          }
        });
  }

  void setControllers(AsyncSnapshot<Message> snapshot) {
    _titleController.text = snapshot.requireData.title!;
    _contentController.text = snapshot.requireData.content!;
    _senderController.text = snapshot.requireData.sendersName!;
  }

  Scaffold inboxMessagesListView(BuildContext context, Message message) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message.title!),
        actions: const <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              enabled: false,
              maxLines: 1,
              decoration: InputDecoration(labelText: "Title: "),
            ),
            TextField(
              enabled: false,
              minLines: 5,
              maxLines: null,
              controller: _contentController,
              decoration: InputDecoration(labelText: message.content),
            ),
            TextField(
              controller: _senderController,
              enabled: false,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: "Send by: " + message.sendersName!),
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewMessageWidget.messageIdOnly(messageId)))
              },
              child: Text('Reply'),
            )
          ],
        ),
      ),
    );
  }
}
