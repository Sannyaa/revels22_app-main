part of 'delegate_card_cubit.dart';

abstract class DelegateCardState extends Equatable {
  const DelegateCardState();

  @override
  List<Object> get props => [];
}

class DelegateCardLoading extends DelegateCardState {}

class DelegateCardLoaded extends DelegateCardState {
  final List<DelegateCard> data;

  const DelegateCardLoaded(this.data);
}

class DelegateCardLaunchUrl extends DelegateCardState {
  final String url;

  DelegateCardLaunchUrl(this.url);
}
