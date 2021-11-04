import 'package:e_diary_mobile/messages/message_home.dart';
import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/model/message_status.dart';
import 'package:e_diary_mobile/shared/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'message_service.dart';

class InboxPage extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getInboxMessages(),
            builder: (context, AsyncSnapshot<List<Message>> snapshot) {
              if (snapshot.hasData) {
                return inboxMessagesListView(context, snapshot.requireData);
              } else {
                return NoDataPage();
              }
            }));
  }

  Scaffold inboxMessagesListView(BuildContext context, List<Message> messages) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: <Widget>[],
      ),
      body: ListView.separated(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.message, size: 30.0),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: _title('${messages[index].title}',
                TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            selected: messages[index].status ==
                MessageStatus.SENT.formattedToString(),
            subtitle: Text(
                '${messages[index].sendersName} \n${messages[index].simpleDateFormat}'),
            dense: true,
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MessagesPage()),
              ),
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget _title(String text, TextStyle style) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
