import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role {
  int id;
  String name;

  Role(this.id, this.name);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  String toString() {
    return 'Role{id: $id, role: $name}';
  }
}

String getRawRoleNames(List<Role> roles) {
  String roleBuilder = '';
  roles.forEach((element) {
    roleBuilder += element.name.split("ROLE_")[1] + '\n';
  });
  if ((roleBuilder != null) && (roleBuilder.length > 0) && roleBuilder.endsWith('\n')) {
    roleBuilder = roleBuilder.substring(0, (roleBuilder.length-1));
  }
  return roleBuilder;
}