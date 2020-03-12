import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class TaskItem {
  final int id;
  final String frequency;
  final String time;
  final String amount;
  final String billType;
  final String category;
  final String remark;
  final String confirm;
  final String payMethod;

  TaskItem([this.id,
      this.frequency,
      this.time,
      this.amount,
      this.billType,
      this.category,
      this.remark,
      this.confirm,
      this.payMethod]);

  factory TaskItem.fromJson(Map<String, dynamic> json) => _$TaskItemFromJson(json);

  Map<String, dynamic> toJson() => _$TaskItemToJson(this);
}
