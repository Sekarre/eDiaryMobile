import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circular_indicator.dart';

class NoDataWidget extends StatefulWidget {

  String text;

  NoDataWidget(this.text, {Key? key}) : super(key: key);

  @override
  State<NoDataWidget> createState() => _NoDataWidget(text);
}

class _NoDataWidget extends State<NoDataWidget> {

  Timer? _timer;
  bool _isTimerStopped = false;
  final _infoController = new TextEditingController();

  _NoDataWidget(String text) {
    _timer = Timer(const Duration(milliseconds: 2000), () {
      if (!_isTimerStopped) {
        setState(() {
          _isTimerStopped = true;
          _infoController.text = text;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isTimerStopped) {
      return styledCircularIndicator();
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(builder: (context, snapshot) {
          return buildPadding(context);
        }),
      );
    }
  }

  Padding buildPadding(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(_infoController.text,
          style: TextStyle(
              fontSize: 18,
          ),
        ),
      ),
    );
  }
}
