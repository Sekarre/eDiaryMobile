import 'package:e_diary_mobile/model/user.dart';
import 'package:e_diary_mobile/profile/profile_service.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final TextEditingController _infocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _infocontroller.text = 'No data to display';
    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder<User>(
          builder: (context, snapshot) {
            return buildPadding(context);
          }),
    );
  }

  Padding buildPadding(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextField(
            enabled: false,
            maxLines: null,
            controller: _infocontroller,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back'),
          )
        ],
      ),
    );
  }
}
