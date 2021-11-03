import 'package:e_diary_mobile/model/address.dart';
import 'package:e_diary_mobile/model/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String name;
  int messageNumber;
  String username;
  Address? address;
  List<Role> roles;

  User(this.id, this.name, this.messageNumber, this.username, this.address, this.roles);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, name: $name, messageNumber: $messageNumber, username: $username, address: $address, roles: $roles}';
  }
}