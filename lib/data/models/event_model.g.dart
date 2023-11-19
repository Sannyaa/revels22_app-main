// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventHeads _$EventHeadsFromJson(Map<String, dynamic> json) => EventHeads(
      name: json['name'] as String,
      phoneNo: json['phoneNo'] as int,
      email: json['email'] as String,
    );

Map<String, dynamic> _$EventHeadsToJson(EventHeads instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNo': instance.phoneNo,
      'email': instance.email,
    };

Rounds _$RoundsFromJson(Map<String, dynamic> json) => Rounds(
      roundNumber: json['roundNumber'] as int,
      judges: json['judges'] as String?,
    );

Map<String, dynamic> _$RoundsToJson(Rounds instance) => <String, dynamic>{
      'roundNumber': instance.roundNumber,
      'judges': instance.judges,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['_id'] as String,
      eventID: json['eventID'] as int,
      name: json['name'] as String,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => Rounds.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventType: $enumDecode(_$EventTypeEnumMap, json['eventType']),
      mode: $enumDecode(_$ModeEnumMap, json['mode']),
      participationCriteria: json['participationCriteria'] as String,
      prize: json['prize'] as String?,
      minMembers: json['minMembers'] as int,
      maxMembers: json['maxMembers'] as int,
      eventHeads: (json['eventHeads'] as List<dynamic>)
          .map((e) => EventHeads.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventDateTime: json['eventDateTime'] == null
          ? null
          : DateTime.parse(json['eventDateTime'] as String),
      eventVenue: json['eventVenue'] as String?,
      registrationDeadline: json['registrationDeadline'] == null
          ? null
          : DateTime.parse(json['registrationDeadline'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isActive: json['isActive'] as bool,
      delegateCards: (json['delegateCards'] as List<dynamic>)
          .map((e) => DelegateCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
      teamDelegateCard: json['teamDelegateCard'] as bool,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      '_id': instance.id,
      'eventID': instance.eventID,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'eventType': _$EventTypeEnumMap[instance.eventType],
      'mode': _$ModeEnumMap[instance.mode],
      'participationCriteria': instance.participationCriteria,
      'prize': instance.prize,
      'minMembers': instance.minMembers,
      'maxMembers': instance.maxMembers,
      'eventHeads': instance.eventHeads,
      'eventDateTime': instance.eventDateTime?.toIso8601String(),
      'eventVenue': instance.eventVenue,
      'registrationDeadline': instance.registrationDeadline?.toIso8601String(),
      'tags': instance.tags,
      'isActive': instance.isActive,
      'teamDelegateCard': instance.teamDelegateCard,
      'delegateCards': instance.delegateCards,
      'rounds': instance.rounds,
    };

const _$EventTypeEnumMap = {
  EventType.CULTURAL: 'CULTURAL',
  EventType.SPORTS: 'SPORTS',
  EventType.MISC: 'MISC',
};

const _$ModeEnumMap = {
  Mode.OFFLINE: 'OFFLINE',
  Mode.ONLINE: 'ONLINE',
};
