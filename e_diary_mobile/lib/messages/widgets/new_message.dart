
import 'package:e_diary_mobile/messages/widgets/outbox.dart';
import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:e_diary_mobile/shared/services/user_service.dart';
import 'package:flutter/material.dart';

import '../message_service.dart';

class NewMessageWidget extends StatefulWidget {

  int? messageId;

  NewMessageWidget({Key? key, this.messageId}) : super(key: key);
  NewMessageWidget.messageIdOnly(this.messageId);

  @override
  State<StatefulWidget> createState() => _NewMessageWidget(messageId);
}

class _NewMessageWidget extends State<NewMessageWidget> {

  _NewMessageWidget(this.messageId);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _readersController = TextEditingController();

  final List<int> _readersId = [];
  List<DropdownMenuItem<User>> _dropdownItems = [];
  List<User> users = [];

  int? messageId;
  Message? messageToReply;

  @override
  void initState() {
    super.initState();
   _loadUsers();
   _setMessageReaderIfPresent();
  }

  _loadUsers() async {
    var result = await getAllUsers();
    setState(() {
      users = result;
      _dropdownItems = _mapUsersToDropdownItems();
    });
  }

  _setMessageReaderIfPresent() async {
    if (messageId != null) {
      messageToReply = await getInboxSingleMessage(messageId!);
      setState(() {
        removeUserFromDropdownList(users, messageToReply!.sendersId!);
        _readersId.add(messageToReply!.sendersId!);
        _readersController.text = _readersController.text + messageToReply!.sendersName! + ", ";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (users.isNotEmpty) {
      return newMessageForm(context);
    } else {
      return NoDataWidget(NEW_MESSAGE_ERROR);
    }
  }

  Container newMessageForm(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: buildAppBar("New message"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xFF2E7D32),
                controller: _titleController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                      //borderRadius: new BorderRadius.circular(30.0)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                      //borderRadius: new BorderRadius.circular(30.0)
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xFF2E7D32),
                controller: _contentController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                    labelText: 'Content',
                    labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _readersController,
                readOnly: true,
                maxLines: null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  enabled: true,
                  labelText: 'Readers',
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _resetDropdown();
                    },
                    icon: Icon(Icons.clear,color: Color(0xFF2E7D32),),
                  ),
                ),
              ),
              DropdownButton<User>(
                hint: Text('To: ', style: TextStyle(color: Colors.white)),
                value: null,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                iconSize: 24,
                elevation: 16,
                dropdownColor: Color(0xFF424242),
                style: const TextStyle(color: Colors.white, fontSize: 20),
                underline: Container(
                  height: 2,
                  color: Color(0xFF2E7D32),
                ),
                onChanged: (User? reader) {
                  addReader(reader);
                  removeUserFromDropdownList(users, reader!.id);
                },
                items: _dropdownItems,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical:25.0),
                width: double.infinity,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () async {
                    var result = await createAndSendMessage();
                    if (result == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OutboxWidget()
                          )
                      );
                    } else if (result == false) {
                      openPopup(context, 'Error while sending message', 'Try later');
                    }
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(0xFF2E7D32),
                  child: Text(
                    'Send',
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

  void _resetDropdown() {
    _readersController.clear();
    _readersId.clear();
    setState(() {
      _dropdownItems = _mapUsersToDropdownItems();
    });
  }

  List<DropdownMenuItem<User>> _mapUsersToDropdownItems() {
    return users.map<DropdownMenuItem<User>>((User user) {
      return DropdownMenuItem<User>(
        value: user,
        child: Text(user.name),
      );
    }).toList();
  }

  Future<bool> createAndSendMessage() async {
    var title = _titleController.text;
    var content = _contentController.text;

    Message message = new Message(null, title, content, null, null, null, null, null, null, _readersId);

    var result = await sendNewMessage(message);
    _clearText();

    return result;
  }

  addReader(User? reader) {
    _readersId.add(reader!.id);
    _readersController.text = _readersController.text + reader.name + ", ";
  }

  removeUserFromDropdownList(List<User> users, int userId) {
    setState(() {
      _dropdownItems.removeWhere((elem) => elem.value!.id == userId);
    });
  }

  _clearText() {
    _titleController.text = '';
    _contentController.text = '';
    _resetDropdown();
  }
}
