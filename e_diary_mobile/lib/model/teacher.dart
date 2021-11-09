import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {

  int userId;
  int id;
  String name;

  Teacher(this.userId, this.id, this.name);

  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);

  @override
  String toString() {
    return 'Teacher{userId: $userId, id: $id, name: $name}';
  }
}