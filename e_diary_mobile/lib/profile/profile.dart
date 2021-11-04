import 'package:e_diary_mobile/auth/auth.dart';
import 'package:e_diary_mobile/model/role.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:e_diary_mobile/profile/profile_service.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureBuilder<User>(
          future: getProfile(),
          builder: (context, snapshot) {
            return buildPadding(context, snapshot.requireData);
          }),
    );
  }

  Padding buildPadding(BuildContext context, User data) {
    _nameController.text = data.name;
    _usernameController.text = data.username;
    _roleController.text = getRawRoleNames(data.roles);
    if (data.address != null) {
      _addressController.text = data.address!.toRawAddress();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          )
        ],
      ),
    );
  }

  _openPopup(context) {
    Alert(
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
                  displayDialog(context, "An Error Occurred", "Wrong password");
                }
              } else {
                displayDialog(context, "An Error Occurred", "Confirm password does not match NEW password");
              }
            },
            child: Text(
              "Change",
              style: TextStyle(color: Colors.white, fontSize: 20),
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

void displayDialog(context, title, text) => showDialog(
  context: context,
  builder: (context) =>
      AlertDialog(
          title: Text(title),
          content: Text(text)
      ),
);