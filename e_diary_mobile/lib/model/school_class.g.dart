// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolClass _$SchoolClassFromJson(Map<String, dynamic> json) => SchoolClass(
      json['id'] as int?,
      json['name'] as String,
      json['studentCouncilId'] as int?,
      json['teacherName'] as String?,
      json['teacherId'] as int,
      json['parentCouncilId'] as int?,
      (json['students'] as List<dynamic>?)
          ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['eventsId'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['schoolPeriodsId'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      (json['lessonsId'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$SchoolClassToJson(SchoolClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'studentCouncilId': instance.studentCouncilId,
      'teacherName': instance.teacherName,
      'teacherId': instance.teacherId,
      'parentCouncilId': instance.parentCouncilId,
      'students': instance.students?.map((e) => e.toJson()).toList(),
      'eventsId': instance.eventsId,
      'schoolPeriodsId': instance.schoolPeriodsId,
      'lessonsId': instance.lessonsId,
    };
