import 'package:e_diary_mobile/model/student.dart';
import 'package:json_annotation/json_annotation.dart';

part 'school_class.g.dart';

@JsonSerializable(explicitToJson: true)
class SchoolClass {

  int? id;
  String name;
  int? studentCouncilId;
  String? teacherName;
  int teacherId;
  int? parentCouncilId;
  List<Student>? students;
  List<int>? eventsId;
  List<int>? schoolPeriodsId;
  List<int>? lessonsId;

  SchoolClass(
      this.id,
      this.name,
      this.studentCouncilId,
      this.teacherName,
      this.teacherId,
      this.parentCouncilId,
      this.students,
      this.eventsId,
      this.schoolPeriodsId,
      this.lessonsId);


  factory SchoolClass.fromJson(Map<String, dynamic> json) => _$SchoolClassFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolClassToJson(this);

  static SchoolClass builder(String className, int formTutorId) {
    return SchoolClass(null, className, null, null, formTutorId, null, null, null, null, null);
  }
}