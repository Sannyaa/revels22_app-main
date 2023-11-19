// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      name: json['name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      phoneNo: json['phoneNo'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      token: json['token'] as String,
      passwordResetToken: json['passwordResetToken'] as String,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'role': instance.role,
      'email': instance.email,
      'phoneNo': instance.phoneNo,
      'token': instance.token,
      'passwordResetToken': instance.passwordResetToken,
    };
