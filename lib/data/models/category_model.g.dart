// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      categoryId: json['categoryId'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$CategoryTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'category': instance.category,
      'description': instance.description,
      'type': _$CategoryTypeEnumMap[instance.type],
    };

const _$CategoryTypeEnumMap = {
  CategoryType.CULTURAL: 'CULTURAL',
  CategoryType.SPORTS: 'SPORTS',
  CategoryType.SUPPORTING: 'SUPPORTING',
  CategoryType.MISC: 'MISC',
};
