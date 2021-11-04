import 'package:e_diary_mobile/model/role.dart';
import 'package:e_diary_mobile/model/user.dart';
import 'package:e_diary_mobile/profile/profile_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureBuilder<User>(
          future: getProfile(),
          builder: (context, snapshot) {
            return buildPadding(snapshot.requireData);
          }),
    );
  }

  Padding buildPadding(User data) {

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
              decoration: InputDecoration(
                labelText: "Name"
              ),
            ),
            TextField(
              enabled: false,
              maxLines: null,
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: data.username
              ),
            ),
            TextField(
              controller: _roleController,
              enabled: false,
              maxLines: null,
              decoration: InputDecoration(
                  labelText: "Roles"
              ),
            ),
            TextField(
              controller: _addressController,
              enabled: false,
              maxLines: null,
              decoration: InputDecoration(
                  labelText: "Address"
              ),
            ),
          ],
        ),
      );
  }
}