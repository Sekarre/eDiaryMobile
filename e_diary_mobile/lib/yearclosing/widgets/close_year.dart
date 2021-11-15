import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/role.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:e_diary_mobile/profile/profile_service.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/circular_indicator.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/components/app_common_styles.dart';
import 'package:e_diary_mobile/yearclosing/close_year_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CloseYearWidget extends StatefulWidget {
  CloseYearWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CloseYearWidget();
}

class _CloseYearWidget extends State<CloseYearWidget> {

  bool _isPerformingAction = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar("School year closing"),
        body: Builder(builder: (context) => buildWidgets(context)),
      ),
    );
  }

  Center buildWidgets(context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('Placeholder'),
          ElevatedButton(
            onPressed: _isPerformingAction ? null : () {
              _openPopup(context);
            },
            child: _isPerformingAction ? CircularProgressIndicator() : Text('Close year'),
            style: elevatedButtonStyle,
          )
        ],
      ),
    );
  }

  _openPopup(buildContext) {
    Alert(
      style: customAlertStyle,
        context: buildContext,
        title: "Close school year\n",
        content: Column(
          children: const <Widget>[
            Text('School Year will be close, all data will be archived in pdf files. \nAre you sure u want to close the year?'),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              setState(() {
                _isPerformingAction = true;
              });
              Navigator.of(buildContext, rootNavigator: true).pop();
              var result = await closeYear();
              if (result) {
                setState(() {
                  _isPerformingAction = false;
                });
                openPopup(buildContext, 'Success', 'School year has been closed');
              } else {
                openPopup(buildContext, "An Error Occurred",
                    "Could not close the school year. \nTry again later");
              }
            },
            color: Color(0xFFAB47BC),
            border: Border.all(
                color: Color(0xFF8E24AA), width: 2.0, style: BorderStyle.solid),
            child: const Text(
              "Yes",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
            ),
          ),
          DialogButton(
            onPressed: () async {
              Navigator.of(buildContext, rootNavigator: true).pop();
            },
            color: Color(0xFFAB47BC),
            border: Border.all(
                color: Color(0xFF8E24AA), width: 2.0, style: BorderStyle.solid),
            child: const Text(
              "No",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
            ),
          )
        ]).show();
  }
}
