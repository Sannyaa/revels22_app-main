import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'college_model.g.dart';

@JsonSerializable()
class College extends Equatable {
  final String name;
  final String? state;
  final bool? isMahe;

  const College({
    required this.name,
    required this.state,
    required this.isMahe,
  });

  factory College.fromJson(Map<String, dynamic> json) =>
      _$CollegeFromJson(json);

  Map<String, dynamic> toJson() => _$CollegeToJson(this);

  @override
  List<Object?> get props => [name, state, isMahe];
}