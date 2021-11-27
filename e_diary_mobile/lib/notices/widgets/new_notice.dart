
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

  Container NewNoticeForm(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: buildAppBar("New notice"),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length < 2 || value.length > 20) {
                          return 'Title must be between 2 and 20 characters long.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Color(0xFF2E7D32),
                      keyboardType: TextInputType.multiline,
                      minLines: 8,
                      maxLines: null,
                      controller: _contentController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                          //borderRadius: new BorderRadius.circular(30.0)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                          //borderRadius: new BorderRadius.circular(30.0)
                        ),
                        labelText: 'Content',
                        labelStyle: TextStyle(color: Colors.white),
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical:25.0),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5.0,
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
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xFF2E7D32),
                        child: Text(
                          'Add',
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
              )
          )
      ),
    );
  }
}
