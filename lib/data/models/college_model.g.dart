// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

College _$CollegeFromJson(Map<String, dynamic> json) => College(
      name: json['name'] as String,
      state: json['state'] as String?,
      isMahe: json['isMahe'] as bool?,
    );

Map<String, dynamic> _$CollegeToJson(College instance) => <String, dynamic>{
      'name': instance.name,
      'state': instance.state,
      'isMahe': instance.isMahe,
    };
