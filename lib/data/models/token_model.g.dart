// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToken _$UserTokenFromJson(Map<String, dynamic> json) => UserToken(
      userId: json['userId'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserTokenToJson(UserToken instance) => <String, dynamic>{
      'userId': instance.userId,
      'token': instance.token,
    };

AdminToken _$AdminTokenFromJson(Map<String, dynamic> json) => AdminToken(
      adminId: json['adminId'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$AdminTokenToJson(AdminToken instance) =>
    <String, dynamic>{
      'adminId': instance.adminId,
      'token': instance.token,
    };
