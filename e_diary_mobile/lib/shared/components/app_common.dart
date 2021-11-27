import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration buildBoxDecoration() {
  return const BoxDecoration(
    color: Color(0xFF212121),

  );
}

AppBar buildAppBar(String appTitle) {
  return AppBar(
      title: Text(appTitle),
      actions: const <Widget>[],
      backgroundColor: Color(0xFF303030),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.0),
          )
      )
  );
}
