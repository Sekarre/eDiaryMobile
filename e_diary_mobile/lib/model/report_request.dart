import 'package:json_annotation/json_annotation.dart';

part 'report_request.g.dart';

@JsonSerializable()
class ReportRequest {

  String startTime;
  String endTime;
  List<int> teachersId;

  ReportRequest(this.startTime, this.endTime, this.teachersId);

  factory ReportRequest.fromJson(Map<String, dynamic> json) => _$ReportRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ReportRequestToJson(this);

  @override
  String toString() {
    return 'ReportRequest{startTime: $startTime, endTime: $endTime, teachersId: $teachersId}';
  }
}