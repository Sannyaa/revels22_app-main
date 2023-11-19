import 'package:equatable/equatable.dart';
import 'package:mitrevels22/data/models/delegate_card_model.dart';

import '../../config/enums/enums.dart';
import "category_model.dart";
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventHeads extends Equatable {
  final String name;
  final int phoneNo;
  final String email;
  const EventHeads({
    required this.name,
    required this.phoneNo,
    required this.email,
  });

  factory EventHeads.fromJson(Map<String, dynamic> json) =>
      _$EventHeadsFromJson(json);

  Map<String, dynamic> toJson() => _$EventHeadsToJson(this);

  @override
  List<Object?> get props => [name, phoneNo, email];
}

@JsonSerializable()
class Rounds extends Equatable {
  final int roundNumber;
  final String? judges;
  Rounds({required this.roundNumber, this.judges});

  factory Rounds.fromJson(Map<String, dynamic> json) => _$RoundsFromJson(json);

  Map<String, dynamic> toJson() => _$RoundsToJson(this);

  @override
  List<Object?> get props => [roundNumber, judges];
}

@JsonSerializable()
class Event extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final int eventID;
  final String name;
  final Category? category;
  final String description;
  final EventType eventType;
  final Mode mode;
  final String participationCriteria;
  final String? prize;
  final int minMembers;
  final int maxMembers;
  final List<EventHeads> eventHeads;
  final DateTime? eventDateTime;
  final String? eventVenue;
  final DateTime? registrationDeadline;
  final List<String> tags;
  final bool isActive;
  final bool teamDelegateCard;
  final List<DelegateCard> delegateCards;
  final List<Rounds> rounds;

  Event({
    required this.id,
    required this.eventID,
    required this.name,
    required this.category,
    required this.rounds,
    required this.eventType,
    required this.mode,
    required this.participationCriteria,
    this.prize,
    required this.minMembers,
    required this.maxMembers,
    required this.eventHeads,
    required this.eventDateTime,
    this.eventVenue,
    required this.registrationDeadline,
    required this.tags,
    required this.isActive,
    required this.delegateCards,
    required this.description,
    required this.teamDelegateCard,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [
        id,
        eventID,
        name,
        category,
        description,
        eventType,
        mode,
        participationCriteria,
        prize,
        minMembers,
        maxMembers,
        eventHeads,
        eventDateTime,
        eventVenue,
        registrationDeadline,
        tags,
        isActive,
        delegateCards,
        teamDelegateCard,
        rounds,
      ];
}
