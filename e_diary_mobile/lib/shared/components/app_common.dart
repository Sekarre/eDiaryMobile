import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration buildBoxDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF8E24AA),
          Color(0xFFAB47BC),
          Color(0xFFCE93D8),
          Color(0xFFF3E5F5),
        ],
        stops: [0.1, 0.3, 0.5, 0.9]),
  );
}

AppBar buildAppBar(String appTitle) {
  return AppBar(
      title: Text(appTitle),
      actions: const <Widget>[],
      backgroundColor: Color(0xFFAB47BC),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.0),
          )
      )
  );
}
