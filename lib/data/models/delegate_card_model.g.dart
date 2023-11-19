// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delegate_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DelegateCard _$DelegateCardFromJson(Map<String, dynamic> json) => DelegateCard(
      cardID: json['cardID'] as String,
      documentId: json['_id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$DelegateCardTypeEnumMap, json['type']),
      mahePrice: json['mahePrice'] as int,
      description: json['description'] as String,
      isActive: json['isActive'] as bool,
      nonMahePrice: json['nonMahePrice'] as int,
      mitPrice: json['mitPrice'] as int,
    );

Map<String, dynamic> _$DelegateCardToJson(DelegateCard instance) =>
    <String, dynamic>{
      'cardID': instance.cardID,
      'name': instance.name,
      'type': _$DelegateCardTypeEnumMap[instance.type],
      'mahePrice': instance.mahePrice,
      'nonMahePrice': instance.nonMahePrice,
      'isActive': instance.isActive,
      'description': instance.description,
      '_id': instance.documentId,
      'mitPrice': instance.mitPrice,
    };

const _$DelegateCardTypeEnumMap = {
  DelegateCardType.PROSHOW: 'PROSHOW',
  DelegateCardType.INF: 'INF',
  DelegateCardType.GAMING: 'GAMING',
  DelegateCardType.WORKSHOPS: 'WORKSHOPS',
  DelegateCardType.GENERAL: 'GENERAL',
  DelegateCardType.SPORTS: 'SPORTS',
};
