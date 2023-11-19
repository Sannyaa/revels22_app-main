part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class EventsFetchEvent extends EventsEvent {}

class EventFilterEvent extends EventsEvent {
  final Category category;
  EventFilterEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class ClearFilterEvent extends EventsEvent {}
