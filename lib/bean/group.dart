import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class GroupItemUser {
  final int id;
  final String nickName;
  final String avatar;

  GroupItemUser(this.id, this.nickName, this.avatar);

  factory GroupItemUser.fromJson(Map<String, dynamic> json) =>
      _$GroupItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$GroupItemUserToJson(this);
}

@JsonSerializable()
class GroupItem {
  final int id;
  final String name;
  final String desc;
  final String usage;
  final String type;
  final int creatorId;
  final String isDefault;
  final GroupItemUser creator;
  final List<GroupItemUser> users;

  GroupItem(this.id, this.name, this.desc, this.usage, this.type, this.creatorId, this.users, this.isDefault, this.creator);

  factory GroupItem.fromJson(Map<String, dynamic> json) =>
      _$GroupItemFromJson(json);

  Map<String, dynamic> toJson() => _$GroupItemToJson(this);
}
