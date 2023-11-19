part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  final User user;

  const LoadUser({required this.user});

  @override
  List<Object> get props => [user];
}

class FetchUser extends UserEvent {
  final String token;

  const FetchUser({required this.token});

  @override
  List<Object> get props => [token];
}

class LogoutEvent extends UserEvent {
  final String token;

  const LogoutEvent({required this.token});

  @override
  List<Object> get props => [token];
}