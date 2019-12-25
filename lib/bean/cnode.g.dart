// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cnode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicAuthor _$TopicAuthorFromJson(Map<String, dynamic> json) {
  return TopicAuthor(
    json['loginname'] as String,
    json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$TopicAuthorToJson(TopicAuthor instance) =>
    <String, dynamic>{
      'loginname': instance.loginname,
      'avatar_url': instance.avatar_url,
    };

TopicsItem _$TopicsItemFromJson(Map<String, dynamic> json) {
  return TopicsItem(
    json['id'] as String,
    json['author_id'] as String,
    json['tab'] as String,
    json['content'] as String,
    json['title'] as String,
    json['last_reply_at'] as String,
    json['good'] as bool,
    json['top'] as bool,
    json['reply_count'] as int,
    json['visit_count'] as int,
    json['create_at'] as String,
    json['author'] == null
        ? null
        : TopicAuthor.fromJson(json['author'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TopicsItemToJson(TopicsItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_id': instance.author_id,
      'tab': instance.tab,
      'content': instance.content,
      'title': instance.title,
      'last_reply_at': instance.last_reply_at,
      'good': instance.good,
      'top': instance.top,
      'reply_count': instance.reply_count,
      'visit_count': instance.visit_count,
      'create_at': instance.create_at,
      'author': instance.author,
    };
