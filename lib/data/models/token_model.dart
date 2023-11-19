import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class UserToken {
  String userId;
  String token;
  UserToken({required this.userId, required this.token});
factory UserToken.fromJson(Map<String, dynamic> json) =>
      _$UserTokenFromJson(json);
}

@JsonSerializable()
class AdminToken {
  String adminId;
  String token;
  AdminToken({required this.adminId, required this.token});
factory AdminToken.fromJson(Map<String, dynamic> json) =>
      _$AdminTokenFromJson(json);
}
