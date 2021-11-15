import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/role.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:e_diary_mobile/profile/profile_service.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/components/app_common_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfilePage extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF8E24AA),
            Color(0xFFAB47BC),
            Color(0xFFCE93D8),
            Color(0xFFF3E5F5),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Text("Profile"),
            actions: <Widget>[],
            backgroundColor: Color(0xFFAB47BC),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.0),
                )
            )
        ),
        body: FutureBuilder<User>(
          future: getProfile(),
          builder: (context, snapshot) {
          return buildPadding(context, snapshot.requireData);
        }),
        ),
    );
  }

  Padding buildPadding(BuildContext context, User data) {
    _nameController.text = data.name;
    _usernameController.text = data.username!;
    _roleController.text = getRawRoleNames(data.roles!);
    if (data.address != null) {
      _addressController.text = data.address!.toRawAddress();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _nameController,
            enabled: false,
            maxLines: null,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            enabled: false,
            maxLines: null,
            controller: _usernameController,
            decoration: InputDecoration(labelText: data.username),
          ),
          TextField(
            controller: _roleController,
            enabled: false,
            maxLines: null,
            decoration: InputDecoration(labelText: "Roles"),
          ),
          TextField(
            controller: _addressController,
            enabled: false,
            maxLines: null,
            decoration: InputDecoration(labelText: "Address"),
          ),
          ElevatedButton(
            onPressed: () {
              _openPopup(context);
            },
            child: Text('Change password'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFAB47BC),
              shape: StadiumBorder(
                 side: BorderSide(
                  color: Color(0xFF8E24AA), width: 1)),
              textStyle: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
          )
        ],
      ),
    );
  }

  _openPopup(context) {
    Alert(
        style: customAlertStyle,
        context: context,
        title: "LOGIN",
        content: Column(
          children: <Widget>[
            TextField(
             controller: _oldPasswordController ,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Old password',
              ),
            ),
            TextField(
             controller: _newPasswordController ,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'New password',
              ),
            ),
            TextField(
             controller: _confirmPasswordController ,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Confirm password',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              bool isChange = onChangePassword();
              if(isChange) {
                var change = await changePassword(_oldPasswordController.text, _newPasswordController.text);
                if (change != null) {
                  Navigator.of(context, rootNavigator: true).pop();
                } else {
                  openPopup(context, "An Error Occurred", "Wrong password");
                }
              } else {
                openPopup(context, "An Error Occurred", "Confirm password does not match NEW password");
              }
            },
            color: Color(0xFFAB47BC),
            border: Border.all(color: Color(0xFF8E24AA), width: 2.0, style: BorderStyle.solid),
            child: Text(
              "Change",
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )
        ]).show();
  }


  bool onChangePassword() {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (oldPassword == null && newPassword == null && confirmPassword == null) {
      return false;
    }

    if (newPassword != confirmPassword) {
      return false;
    }
    return true;
  }
}