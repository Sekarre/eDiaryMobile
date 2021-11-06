import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  int? id;
  String? title;
  String? content;
  String? date;
  String? simpleDateFormat;
  String? status;
  int? sendersId;
  String? sendersName;
  List<String>? readersName;
  List<int>? readersId;


  Message(this.id, this.title, this.content, this.date, this.simpleDateFormat, this.status,
      this.sendersId, this.sendersName, this.readersName, this.readersId);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() {
    return 'Message{id: $id, title: $title, content: $content, date: $simpleDateFormat, status: $status, sendersId: $sendersId, sendersName: $sendersName, readersName: $readersName, readersId: $readersId}';
  }
}
