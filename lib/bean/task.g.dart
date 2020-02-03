// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) {
  return TaskItem(
    json['id'] as int,
    json['frequency'] as String,
    json['time'] as String,
    json['amount'] as int,
    json['billType'] as String,
    json['category'] as String,
    json['remark'] as String,
    json['confirm'] as String,
  );
}

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'id': instance.id,
      'frequency': instance.frequency,
      'time': instance.time,
      'amount': instance.amount,
      'billType': instance.billType,
      'category': instance.category,
      'remark': instance.remark,
      'confirm': instance.confirm,
    };
