part of 'user_data_cubit.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserEventsLoadSuccess extends UserDataState {
  final List<Team> events;

  const UserEventsLoadSuccess({required this.events});

  @override
  List<Object> get props => [events];
}

class UserEventsLoadFailure extends UserDataState {
  final String message;

  const UserEventsLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class EventRegistrationLoading extends UserDataState {}

class EventRegistrationSuccess extends UserDataState {}

class EventRegistrationFailure extends UserDataState {}