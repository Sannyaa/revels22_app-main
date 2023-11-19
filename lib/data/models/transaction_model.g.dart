// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      name: json['name'] as String,
      delegateCard:
          DelegateCard.fromJson(json['delegateCard'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      orderId: json['orderId'] as String,
      isPaymentConfirmed: json['isPaymentConfirmed'] as bool,
      amount: json['amount'] as String,
      transactionData: json['transactionData'] as Object,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'delegateCard': instance.delegateCard,
      'user': instance.user,
      'orderId': instance.orderId,
      'transactionData': instance.transactionData,
      'amount': instance.amount,
      'isPaymentConfirmed': instance.isPaymentConfirmed,
    };
