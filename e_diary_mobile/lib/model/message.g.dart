// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      json['id'] as int?,
      json['title'] as String?,
      json['content'] as String?,
      json['date'] as String?,
      json['simpleDateFormat'] as String?,
      json['status'] as String?,
      json['sendersId'] as int?,
      json['sendersName'] as String?,
      (json['readersName'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['readersId'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'date': instance.date,
      'simpleDateFormat': instance.simpleDateFormat,
      'status': instance.status,
      'sendersId': instance.sendersId,
      'sendersName': instance.sendersName,
      'readersName': instance.readersName,
      'readersId': instance.readersId,
    };
