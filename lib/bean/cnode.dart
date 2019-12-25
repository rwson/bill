import 'package:json_annotation/json_annotation.dart';

part 'cnode.g.dart';

@JsonSerializable()
class TopicAuthor {
  String loginname;
  String avatar_url;

  TopicAuthor(
    this.loginname,
    this.avatar_url
  );

  factory TopicAuthor.fromJson(Map<String, dynamic> json) => _$TopicAuthorFromJson(json);

  Map<String, dynamic> toJson() => _$TopicAuthorToJson(this);
}

@JsonSerializable()
class TopicsItem {
  String id;
  String author_id;
  String tab;
  String content;
  String title;
  String last_reply_at;
  bool good;
  bool top;
  int reply_count;
  int visit_count;
  String create_at;

  TopicAuthor author;

  TopicsItem(
    this.id,
    this.author_id,
    this.tab,
    this.content,
    this.title,
    this.last_reply_at,
    this.good,
    this.top,
    this.reply_count,
    this.visit_count,
    this.create_at,
    this.author
  );

  factory TopicsItem.fromJson(Map<String, dynamic> json) => _$TopicsItemFromJson(json);

  Map<String, dynamic> toJson() => _$TopicsItemToJson(this);
}

class CNodeBean {

  bool success;

  List<TopicsItem> topics;

  CNodeBean(
    this.success,
    this.topics
  );
}