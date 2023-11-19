import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mitrevels22/data/models/delegate_card_model.dart';
import 'package:mitrevels22/data/models/role_model.dart';

import '../../config/enums/enums.dart';

part 'user_model.g.dart';

@JsonSerializable()
class Accommodation extends Equatable {
  final bool required;
  final DateTime? arrivalDateTime;
  const Accommodation({required this.required, this.arrivalDateTime});

  @override
  List<Object> get props => [required];

  factory Accommodation.fromJson(Map<String, dynamic> json) =>
      _$AccommodationFromJson(json);

  Map<String, dynamic> toJson() => _$AccommodationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  final int userID;
  final String token;
  final String? passwordResetToken;
  final String name;
  final String email;
  final Role role;
  final bool isEmailVerified;
  final int mobileNumber;
  final String registrationNumber;
  final String course;
  final String college;
  final int isMahe;
  final Accommodation accommodation;
  final Status status;
  final List<DelegateCard> delegateCards;
  final List<DelegateCard> pendingDelegateCards;
  @JsonKey(name: '_id')
  final String documentId;
  const User(
      {required this.userID,
      required this.token,
      required this.passwordResetToken,
      required this.name,
      required this.email,
      required this.isEmailVerified,
      required this.mobileNumber,
      required this.registrationNumber,
      required this.course,
      required this.isMahe,
      required this.accommodation,
      required this.status,
      required this.delegateCards,
      required this.college,
      required this.role,
      required this.documentId,
      required this.pendingDelegateCards});

  @override
  List<Object> get props => [
        userID,
        token,
        name,
        role,
        email,
        isEmailVerified,
        mobileNumber,
        registrationNumber,
        course,
        college,
        isMahe,
        accommodation,
        status,
        delegateCards,
        pendingDelegateCards,
        documentId
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
