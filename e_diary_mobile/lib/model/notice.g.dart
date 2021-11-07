// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      json['id'] as int?,
      json['title'] as String?,
      json['content'] as String?,
      json['date'] as String?,
      json['authorId'] as int?,
      json['authorName'] as String?,
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'date': instance.date,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
    };
