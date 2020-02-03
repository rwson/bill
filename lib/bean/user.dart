import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String token;
  final String avatar;
  final String nickname;
  final String lastLogin;
  final String lastDevice;
  final String mobile;
  final String registrationId;

  User(
      [this.id,
      this.token,
      this.avatar,
      this.nickname,
      this.lastDevice,
      this.lastLogin,
      this.mobile,
      this.registrationId]);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
