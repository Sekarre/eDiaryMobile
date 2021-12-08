import 'package:e_diary_mobile/shared/app_common_styles.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../school_year_service.dart';

class SchoolYearCloseWidget extends StatefulWidget {
  SchoolYearCloseWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SchoolYearCloseWidget();
}

class _SchoolYearCloseWidget extends State<SchoolYearCloseWidget> {

  bool _isPerformingAction = false;
  int currentYear = DateTime.now().year;

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
          Container(
            padding: EdgeInsets.symmetric(vertical:25.0),
            width: 250,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: _isPerformingAction ? null : () {
                _openPopup(context);
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Color(0xFF2E7D32),
              child: _isPerformingAction ?
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      child: CircularProgressIndicator(),
                      height: 20.0,
                      width: 25,
                    ),
                    Text(
                      ' Close school year',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ) :
                Text(
                  'Close school year',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ),
          ),
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
          children: <Widget>[
            Text('Current school year - $currentYear will be closed, data will be deleted and archived in pdf files. \nAre you sure u want to close the year?'),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              setState(() {
                _isPerformingAction = true;
              });
              Navigator.of(buildContext, rootNavigator: true).pop();
              var result = await closeSchoolYear();
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
            color: Color(0xFF2E7D32),
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DialogButton(
            onPressed: () async {
              Navigator.of(buildContext, rootNavigator: true).pop();
            },
            color: Color(0xFF2E7D32),
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]).show();
  }
}
