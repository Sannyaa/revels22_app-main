import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mitrevels22/config/enums/enums.dart';

part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Category extends Equatable {
  final String categoryId;
  final String category;
  final String description;
  final CategoryType type;

  const Category({
    required this.categoryId,
    required this.category,
    required this.description,
    required this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object> get props => [category, categoryId, description, type];
}
