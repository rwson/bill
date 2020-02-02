import 'package:json_annotation/json_annotation.dart';

part 'reminder.g.dart';

@JsonSerializable()
class ReminderItem {
  final int id;
  final String frequency;
  final String time;
  final String rule;
  final int back;

  ReminderItem(this.id, this.frequency, this.time, this.rule, this.back);

  factory ReminderItem.fromJson(Map<String, dynamic> json) =>
      _$ReminderItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderItemToJson(this);
}
