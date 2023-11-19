// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      teamID: json['teamID'] as String,
      event: Event.fromJson(json['event'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestedMembers: (json['requestedMembers'] as List<dynamic>)
          .map((e) => RequestedMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['createdBy'] as String,
      rounds: json['rounds'] as List<dynamic>,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'teamID': instance.teamID,
      'event': instance.event,
      'members': instance.members,
      'requestedMembers': instance.requestedMembers,
      'createdBy': instance.createdBy,
      'rounds': instance.rounds,
    };
