// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      roundNumber: json['roundNumber'] as int,
      isPresent: json['isPresent'] as bool,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'roundNumber': instance.roundNumber,
      'isPresent': instance.isPresent,
    };
