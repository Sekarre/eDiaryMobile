// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_year_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndYearReport _$EndYearReportFromJson(Map<String, dynamic> json) =>
    EndYearReport(
      json['id'] as int,
      json['year'] as String,
      json['name'] as String,
      json['userId'] as int,
    );

Map<String, dynamic> _$EndYearReportToJson(EndYearReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'name': instance.name,
      'userId': instance.userId,
    };
