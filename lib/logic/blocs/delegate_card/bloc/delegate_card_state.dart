part of 'delegate_card_bloc.dart';

@immutable
abstract class DelegateCardState {}

class DelegateCardLoading extends DelegateCardState {}

class DelegateCardLoaded extends DelegateCardState {
  final List<DelegateCard> data;

  DelegateCardLoaded(this.data);
  
}
