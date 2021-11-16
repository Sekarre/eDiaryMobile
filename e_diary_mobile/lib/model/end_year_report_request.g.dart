// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_year_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndYearReportRequest _$EndYearReportRequestFromJson(
        Map<String, dynamic> json) =>
    EndYearReportRequest(
      (json['reportIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$EndYearReportRequestToJson(
        EndYearReportRequest instance) =>
    <String, dynamic>{
      'reportIds': instance.reportIds,
    };
