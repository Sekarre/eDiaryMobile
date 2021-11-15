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
  backgroundColor: const Color(0xFFF3E5F5),
  animationDuration: const Duration(milliseconds: 300),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    side: const BorderSide(
      color: Color(0xFFCE93D8),
    ),
  ),
  titleStyle: const TextStyle(
    color: Colors.black,
  ),
  alertAlignment: Alignment.center);

var elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: const Color(0xFFAB47BC),
    shape: const StadiumBorder(side: BorderSide(color: Color(0xFF8E24AA), width: 1)),
    textStyle: const TextStyle(fontWeight: FontWeight.bold));
