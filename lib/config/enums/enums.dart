import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum EventType {
  // ignore: constant_identifier_names
  CULTURAL,
  // ignore: constant_identifier_names
  SPORTS,
  // ignore: constant_identifier_names
  MISC
}

@JsonEnum()
enum Mode {
  // ignore: constant_identifier_names
  OFFLINE,
  // ignore: constant_identifier_names
  ONLINE
}

@JsonEnum()
enum Status {
  // ignore: constant_identifier_names
  VERIFIED,
  // ignore: constant_identifier_names
  UNVERIFIED,
  // ignore: constant_identifier_names
  REJECTED,
  // ignore: constant_identifier_names
  BANNED
}

@JsonEnum()
enum CategoryType {
  // ignore: constant_identifier_names
  CULTURAL,
  // ignore: constant_identifier_names
  SPORTS,
  // ignore: constant_identifier_names
  SUPPORTING,
  // ignore: constant_identifier_names
  MISC
}

@JsonEnum()
enum DelegateCardType {
  // ignore: constant_identifier_names
  PROSHOW,
  // ignore: constant_identifier_names
  INF,
  // ignore: constant_identifier_names
  GAMING,
  // ignore: constant_identifier_names
  WORKSHOPS,
  // ignore: constant_identifier_names
  GENERAL,
  // ignore: constant_identifier_names
  SPORTS
}
