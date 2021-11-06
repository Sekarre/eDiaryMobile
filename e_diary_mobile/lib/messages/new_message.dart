
import 'package:e_diary_mobile/messages/outbox.dart';
import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/services/user_service.dart';
import 'package:flutter/material.dart';

import 'message_service.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewMessagePageWidget();
}

class _NewMessagePageWidget extends State<NewMessagePage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _readersController = TextEditingController();

  final List<int> _readersId = [];
  List<DropdownMenuItem<User>> _dropdownItems = [];
  List<User> users = [];

  @override
  void initState() {
    super.initState();
   _loadUsers();
  }

  _loadUsers() async {
    var result = await getAllUsers();
    setState(() {
      users = result;
      _dropdownItems = users.map<DropdownMenuItem<User>>((User user) {
        return DropdownMenuItem<User>(
          value: user,
          child: Text(user.name),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dropdownItems.isNotEmpty) {
      return newMessageForm(context);
    } else {
      return const CircularProgressIndicator();
    }
  }

  Scaffold newMessageForm(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New message")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    labelText: 'Title'
                ),
              ),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                    labelText: 'Content'
                ),
              ),
              TextField(
                controller: _readersController,
                readOnly: true,
                maxLines: null,
                decoration: InputDecoration(
                  enabled: true,
                    labelText: 'Readers',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _readersController.clear();
                      _readersId.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              DropdownButton<User>(
                hint: Text('To: '),
                value: null,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (User? reader) {
                  addReader(reader);
                  removeReaderFromDropdownList(users, reader);
                },
                items: _dropdownItems,
              ),
              TextButton(
                  onPressed: () async {
                    var result = await createAndSendMessage();
                    if (result == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OutboxPage()
                          )
                      );
                    } else if (result == false) {
                      openPopup(context, 'Error while sending message', 'Try later');
                    }
                  },
                  child: Text("Send")
              )
            ],
          ),
        )
    );
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

  removeReaderFromDropdownList(List<User> users, User? reader) {
    setState(() {
      _dropdownItems.removeWhere((elem) => elem.value!.id == reader!.id);
    });
  }

  _clearText() {
    _titleController.text = '';
    _contentController.text = '';
    _readersController.text = '';
    _readersId.clear();
  }
}
