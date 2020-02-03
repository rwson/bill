import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class TaskItem {
  final int id;
  final String frequency;
  final String time;
  final int amount;
  final String billType;
  final String category;
  final String remark;
  final String confirm;

  TaskItem([this.id,
      this.frequency,
      this.time,
      this.amount,
      this.billType,
      this.category,
      this.remark,
      this.confirm]);

  factory TaskItem.fromJson(Map<String, dynamic> json) => _$TaskItemFromJson(json);

  Map<String, dynamic> toJson() => _$TaskItemToJson(this);
}
