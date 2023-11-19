part of 'featured_events_bloc.dart';

abstract class FeaturedEventsEvent extends Equatable {
  const FeaturedEventsEvent();

  @override
  List<Object> get props => [];
}

class FeaturedEventsInit extends FeaturedEventsEvent {}
