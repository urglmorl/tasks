import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

///flutter packages pub run build_runner build
@JsonSerializable()
class User {
  String login;
  String password;
  String token;

  User({this.login, this.password, this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
