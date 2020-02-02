import 'package:json_annotation/json_annotation.dart';

part 'limit.g.dart';

@JsonSerializable()
class Limit {
  final int limit;

  Limit([this.limit]);

  factory Limit.fromJson(Map<String, dynamic> json) => _$LimitFromJson(json);

  Map<String, dynamic> toJson() => _$LimitToJson(this);
}
