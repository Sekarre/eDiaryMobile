import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var customAlertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: const TextStyle(fontWeight: FontWeight.bold),
  descTextAlign: TextAlign.start,
  backgroundColor: const Color(0xFF424242),
  animationDuration: const Duration(milliseconds: 300),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    side: const BorderSide(
      color: Color(0xFF2E7D32),
    ),
  ),
  titleStyle: const TextStyle(
    color: Colors.white,
  ),
  alertAlignment: Alignment.center);

var elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: const Color(0xFF2E7D32),
    shape: const StadiumBorder(side: BorderSide(color: Color(0xFF2E7D32), width: 1)),
    textStyle: const TextStyle(fontWeight: FontWeight.bold));

var optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);