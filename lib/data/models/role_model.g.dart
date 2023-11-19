// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      type: json['type'] as int,
      accessLevel: json['accessLevel'] as int,
      categoryId: json['categoryId'] as String?,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'type': instance.type,
      'accessLevel': instance.accessLevel,
      'categoryId': instance.categoryId,
      'isActive': instance.isActive,
    };
