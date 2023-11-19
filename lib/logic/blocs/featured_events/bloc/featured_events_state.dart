part of 'featured_events_bloc.dart';

abstract class FeaturedEventsState extends Equatable {
  const FeaturedEventsState();

  @override
  List<Object> get props => [];
}

class FeaturedEventsInitial extends FeaturedEventsState {}

class FeaturedEventsLoaded extends FeaturedEventsState {
  final List<Event> data;

  FeaturedEventsLoaded(this.data);
}
