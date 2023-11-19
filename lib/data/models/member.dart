import 'package:json_annotation/json_annotation.dart';
import 'package:mitrevels22/data/models/attendance.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  @JsonKey(readValue: _user)
  final int userID;
  @JsonKey(readValue: _user)
  final String name;
  @JsonKey(readValue: _user)
  final String email;
  final List<Attendance>? attendance;

  Member({
    required this.userID,
    required this.name,
    required this.attendance,
    required this.email,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);

  static _user(Map json, String key) {
    return json['user'][key];
  }
}

@JsonSerializable()
class RequestedMember {
  final int userID;
  final String name;
  final String email;

  RequestedMember({
    required this.userID,
    required this.name,
    required this.email,
  });

  factory RequestedMember.fromJson(Map<String, dynamic> json) =>
      _$RequestedMemberFromJson(json);

  Map<String, dynamic> toJson() => _$RequestedMemberToJson(this);
}
