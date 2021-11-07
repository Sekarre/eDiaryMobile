import 'package:json_annotation/json_annotation.dart';

part 'notice.g.dart';

@JsonSerializable()
class Notice {
  int? id;
  String? title;
  String? content;
  String? date;

  int? authorId;
  String? authorName;

  Notice(this.id, this.title, this.content, this.date, this.authorId,
      this.authorName);

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);

  @override
  String toString() {
    return 'Notice{id: $id, title: $title, content: $content, date: $date, authorId: $authorId, authorName: $authorName}';
  }

  String getContent() {
    if(content == null)
      return '';
    return content.toString();
  }
}