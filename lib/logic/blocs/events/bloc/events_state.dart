part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoadSuccess extends EventsState {
  final List<Event> events;
  final List<Category> allCategories;
  final List<Category> selectedCategories;
  final DateTime firstDate;
  final DateTime lastDate;

  EventsLoadSuccess({
    required this.events,
    required this.allCategories,
    required this.selectedCategories,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  List<Object> get props => [events, allCategories, selectedCategories];
}

class EventsLoadFailure extends EventsState {}
