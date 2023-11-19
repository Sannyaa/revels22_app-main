part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {
  const UserLoading();

  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String error;

  const UserError({required this.error});

  @override
  List<Object> get props => [error];
}

class UserLoggedOut extends UserState {
  const UserLoggedOut();

  @override
  List<Object> get props => [];
}
