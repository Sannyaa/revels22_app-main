// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevelsFile _$RevelsFileFromJson(Map<String, dynamic> json) => RevelsFile(
      fileName: json['fileName'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      key: json['key'] as String,
    );

Map<String, dynamic> _$RevelsFileToJson(RevelsFile instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'type': instance.type,
      'url': instance.url,
      'key': instance.key,
    };
