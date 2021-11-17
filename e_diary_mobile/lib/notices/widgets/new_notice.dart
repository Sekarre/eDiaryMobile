
import 'package:e_diary_mobile/model/notice.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:flutter/material.dart';

import '../notice_service.dart';
import 'notices.dart';


class NewNoticeWidget extends StatefulWidget {

  NewNoticeWidget({Key? key}) : super(key: key);

  @override
  NewNoticeState createState() {
    return NewNoticeState();
  }
}

class NewNoticeState extends State<NewNoticeWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
      return NewNoticeForm(context);
  }

  Scaffold NewNoticeForm(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("New notice"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.length < 2 || value.length > 20) {
                      return 'Title must be between 2 and 20 characters long.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 8,
                  maxLines: null,
                  controller: _contentController,
                  decoration: const InputDecoration(
                      labelText: 'Content'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.length < 3 || value.length > 255) {
                      return 'Content must be between 2 and 20 characters long.';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var result = await addNotice(
                            Notice.build(_titleController.text, _contentController.text)
                        );
                        if (result == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NoticesWidget()
                              )
                          );
                        } else if (result == false) {
                          openPopup(context, 'Error while adding notice', 'Try again');
                        }
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          )
        )
    );
  }
}
