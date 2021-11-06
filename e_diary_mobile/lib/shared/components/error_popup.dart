import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

openPopup(context, String mainText, String hintText) {
  Alert(
      context: context,
      title: "",
      content: Column(
        children: <Widget>[
          Text(mainText, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
          Text(hintText, style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300)),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
