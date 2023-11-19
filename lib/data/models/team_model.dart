import 'package:mitrevels22/data/models/member.dart';

import 'event_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable()
class Team {
  final String teamID;
  final Event event;
  final List<Member> members;
  final List<RequestedMember> requestedMembers;
  final String createdBy;
  final List rounds;

  Team({
    required this.teamID,
    required this.event,
    required this.members,
    required this.requestedMembers,
    required this.createdBy,
    required this.rounds,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
