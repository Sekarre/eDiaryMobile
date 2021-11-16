import 'package:json_annotation/json_annotation.dart';

part 'end_year_report_request.g.dart';

@JsonSerializable()
class EndYearReportRequest {

  List<int> reportIds;

  EndYearReportRequest(this.reportIds);

  factory EndYearReportRequest.fromJson(Map<String, dynamic> json) => _$EndYearReportRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EndYearReportRequestToJson(this);

  @override
  String toString() {
    return 'EndYearReportRequest{reportIds: $reportIds}';
  }
}