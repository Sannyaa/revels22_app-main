// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      userID: Member._user(json, 'userID') as int,
      name: Member._user(json, 'name') as String,
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map((e) => Attendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: Member._user(json, 'email') as String,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'userID': instance.userID,
      'name': instance.name,
      'email': instance.email,
      'attendance': instance.attendance,
    };

RequestedMember _$RequestedMemberFromJson(Map<String, dynamic> json) =>
    RequestedMember(
      userID: json['userID'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$RequestedMemberToJson(RequestedMember instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'name': instance.name,
      'email': instance.email,
    };
