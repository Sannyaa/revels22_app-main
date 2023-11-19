import 'delegate_card_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class Transaction {
  String name;
  DelegateCard delegateCard;
  User user;
  String orderId;
  Object transactionData;
  String amount;
  bool isPaymentConfirmed;
  Transaction(
      {required this.name,
      required this.delegateCard,
      required this.user,
      required this.orderId,
      required this.isPaymentConfirmed,
      required this.amount,
      required this.transactionData});
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
