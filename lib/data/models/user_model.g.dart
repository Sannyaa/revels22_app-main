// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accommodation _$AccommodationFromJson(Map<String, dynamic> json) =>
    Accommodation(
      required: json['required'] as bool,
      arrivalDateTime: json['arrivalDateTime'] == null
          ? null
          : DateTime.parse(json['arrivalDateTime'] as String),
    );

Map<String, dynamic> _$AccommodationToJson(Accommodation instance) =>
    <String, dynamic>{
      'required': instance.required,
      'arrivalDateTime': instance.arrivalDateTime?.toIso8601String(),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      userID: json['userID'] as int,
      token: json['token'] as String,
      passwordResetToken: json['passwordResetToken'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      isEmailVerified: json['isEmailVerified'] as bool,
      mobileNumber: json['mobileNumber'] as int,
      registrationNumber: json['registrationNumber'] as String,
      course: json['course'] as String,
      isMahe: json['isMahe'] as int,
      accommodation:
          Accommodation.fromJson(json['accommodation'] as Map<String, dynamic>),
      status: $enumDecode(_$StatusEnumMap, json['status']),
      delegateCards: (json['delegateCards'] as List<dynamic>)
          .map((e) => DelegateCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      college: json['college'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      documentId: json['_id'] as String,
      pendingDelegateCards: (json['pendingDelegateCards'] as List<dynamic>)
          .map((e) => DelegateCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userID': instance.userID,
      'token': instance.token,
      'passwordResetToken': instance.passwordResetToken,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role.toJson(),
      'isEmailVerified': instance.isEmailVerified,
      'mobileNumber': instance.mobileNumber,
      'registrationNumber': instance.registrationNumber,
      'course': instance.course,
      'college': instance.college,
      'isMahe': instance.isMahe,
      'accommodation': instance.accommodation.toJson(),
      'status': _$StatusEnumMap[instance.status],
      'delegateCards': instance.delegateCards.map((e) => e.toJson()).toList(),
      'pendingDelegateCards':
          instance.pendingDelegateCards.map((e) => e.toJson()).toList(),
      '_id': instance.documentId,
    };

const _$StatusEnumMap = {
  Status.VERIFIED: 'VERIFIED',
  Status.UNVERIFIED: 'UNVERIFIED',
  Status.REJECTED: 'REJECTED',
  Status.BANNED: 'BANNED',
};
