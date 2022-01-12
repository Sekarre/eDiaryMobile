// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      json['userId'] as int,
      json['id'] as int,
      json['userName'] as String,
      json['className'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'userName': instance.userName,
      'className': instance.className,
    };
