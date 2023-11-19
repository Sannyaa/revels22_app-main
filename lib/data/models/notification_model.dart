
import 'package:mitrevels22/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';


@JsonSerializable()
class Notification {
  String title;
  String message;
  Object payload;
  bool seen;
  User user;
  Notification(
      {required this.title,
      required this.message,
      required this.payload,
      required this.seen,
      required this.user});
factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

}
