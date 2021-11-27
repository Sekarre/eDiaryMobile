import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/role.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:e_diary_mobile/profile/profile_service.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/circular_indicator.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/app_common_styles.dart';
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
      decoration: buildBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar("Profile"),
        body: FutureBuilder<User>(
          future: getProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildPadding(context, snapshot.requireData);
            }
            return styledCircularIndicator();
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
          const SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 15.0),
            controller: _nameController,
            enabled: false,
            maxLines: null,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
              ),
              labelText: "Name:",
              labelStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 15.0),
            enabled: false,
            maxLines: null,
            controller: _usernameController,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
              ),
              labelText: data.username,
              labelStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 15.0),
            controller: _roleController,
            enabled: false,
            maxLines: null,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
              ),
              labelText: "Roles:",
              labelStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 15.0),
            controller: _addressController,
            enabled: false,
            maxLines: null,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
              ),
              labelText: "Address:",
              labelStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _openPopup(context);
            },
            child: Text('Change password'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF2E7D32),
              shape: StadiumBorder(
                 side: BorderSide(
                  color: Color(0xFF2E7D32), width: 1)),
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
            const SizedBox(
              height: 20,
            ),
            TextField(
              cursorColor: Color(0xFF2E7D32),
              controller: _oldPasswordController ,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32),),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32),),
                ),
                icon: Icon(Icons.lock_outlined, color: Colors.white),
                labelText: 'Old password',
                labelStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              cursorColor: Color(0xFF2E7D32),
              controller: _newPasswordController ,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32),),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32),),
                ),
                icon: Icon(Icons.lock_outlined, color: Colors.white),
                labelText: 'New password',
                labelStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              cursorColor: Color(0xFF2E7D32),
              controller: _confirmPasswordController ,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32),),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32),),
                ),
                icon: Icon(Icons.lock_outlined, color: Colors.white),
                labelText: 'Confirm password',
                labelStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
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
            color: Color(0xFF2E7D32),
            border: Border.all(color: Color(0xFF2E7D32), width: 2.0, style: BorderStyle.solid),
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