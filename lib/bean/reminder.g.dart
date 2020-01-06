// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderItem _$ReminderItemFromJson(Map<String, dynamic> json) {
  return ReminderItem(
    json['id'] as int,
    json['frequency'] as String,
    json['time'] as String,
    json['rule'] as String,
    json['back'] as int,
  );
}

Map<String, dynamic> _$ReminderItemToJson(ReminderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frequency': instance.frequency,
      'time': instance.time,
      'rule': instance.rule,
      'back': instance.back,
    };
