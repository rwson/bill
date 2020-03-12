// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupItemUser _$GroupItemUserFromJson(Map<String, dynamic> json) {
  return GroupItemUser(
    json['id'] as int,
    json['nickName'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$GroupItemUserToJson(GroupItemUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'avatar': instance.avatar,
    };

GroupItem _$GroupItemFromJson(Map<String, dynamic> json) {
  return GroupItem(
    json['id'] as int,
    json['name'] as String,
    json['desc'] as String,
    json['usage'] as String,
    json['type'] as String,
    json['creatorId'] as int,
    (json['users'] as List)
        ?.map((e) => e == null
            ? null
            : GroupItemUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['isDefault'] as String,
    json['isPersonal'] as String,
    json['creator'] == null
        ? null
        : GroupItemUser.fromJson(json['creator'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GroupItemToJson(GroupItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'usage': instance.usage,
      'type': instance.type,
      'creatorId': instance.creatorId,
      'isDefault': instance.isDefault,
      'isPersonal': instance.isPersonal,
      'creator': instance.creator,
      'users': instance.users,
    };
