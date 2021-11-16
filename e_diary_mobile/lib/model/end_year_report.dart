import 'package:json_annotation/json_annotation.dart';

part 'end_year_report.g.dart';

@JsonSerializable()
class EndYearReport {

  int id;
  String year;
  String name;
  int userId;

  EndYearReport(this.id, this.year, this.name, this.userId);

  factory EndYearReport.fromJson(Map<String, dynamic> json) => _$EndYearReportFromJson(json);
  Map<String, dynamic> toJson() => _$EndYearReportToJson(this);

  @override
  String toString() {
    return 'EndYearReport{id: $id, year: $year, name: $name, userId: $userId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EndYearReport &&
          runtimeType == other.runtimeType &&
          id == other.id;

  int get hashCode => id.hashCode;
}