import 'package:json_annotation/json_annotation.dart';
import 'package:mitrevels22/data/models/role_model.dart';

part 'admin_model.g.dart';

@JsonSerializable()
class Admin {
  String name;
  String password;
  Role role;
  String email;
  String phoneNo;
  String token;
  String passwordResetToken;
  Admin(
      {required this.name,
      required this.password,
      required this.email,
      required this.phoneNo,
      required this.role,
      required this.token,
      required this.passwordResetToken});
  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
}
