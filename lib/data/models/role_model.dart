import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_model.g.dart';

@JsonSerializable()
class Role extends Equatable {
  final int type;
  final int accessLevel;
  final String? categoryId;
  final bool isActive;

  const Role({
    required this.type,
    required this.accessLevel,
    required this.categoryId,
    required this.isActive,
  });

  
  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  @override
  List<Object?> get props => [type, accessLevel, categoryId, isActive];

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
