import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
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

  Container inboxMessagesListView(BuildContext context, Message message) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(message.title!),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _titleController,
                enabled: false,
                maxLines: 1,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  labelText: "Title: ",
                  labelStyle: TextStyle(color: Colors.white)
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                enabled: false,
                minLines: 5,
                maxLines: null,
                controller: _contentController,
                decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                    ),
                  labelText: "Content: ",
                  labelStyle: TextStyle(color: Colors.white)
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _senderController,
                enabled: false,
                maxLines: 1,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  labelText: "Send by: " + message.sendersName!,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical:25.0),
                width: double.infinity,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewMessageWidget.messageIdOnly(messageId)))
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(0xFF2E7D32),
                  child: Text(
                    'Reply',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
