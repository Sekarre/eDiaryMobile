import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {

  int userId;
  int id;
  String userName;
  String className;

  Student(this.userId, this.id, this.userName, this.className);

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @override
  String toString() {
    return 'Student{userId: $userId, id: $id, userName: $userName, className: $className}';
  }
}