import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mitrevels22/config/enums/enums.dart';
part 'delegate_card_model.g.dart';

@JsonSerializable()
class DelegateCard extends Equatable {
  final String cardID;
  final String name;
  final DelegateCardType type;
  final int mahePrice;
  final int nonMahePrice;
  final bool isActive;
  final String description;
  @JsonKey(name: '_id')
  final String documentId;
  final int mitPrice;

  const DelegateCard({
    required this.cardID,
    required this.documentId,
    required this.name,
    required this.type,
    required this.mahePrice,
    required this.description,
    required this.isActive,
    required this.nonMahePrice,
    required this.mitPrice,
  });
  @override
  List<Object> get props => [
        cardID,
        name,
        type,
        mahePrice,
        nonMahePrice,
        isActive,
        description,
        mitPrice,
        documentId,
      ];

  factory DelegateCard.fromJson(Map<String, dynamic> json) =>
      _$DelegateCardFromJson(json);
  Map<String, dynamic> toJson() => _$DelegateCardToJson(this);
}
