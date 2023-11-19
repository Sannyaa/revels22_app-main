part of 'token_cubit.dart';

abstract class TokenState extends Equatable {
  const TokenState();

  @override
  List<Object> get props => [];
}

class TokenInitial extends TokenState {}

class TokenLoading extends TokenState {}

class TokenExists extends TokenState {
  final String token;

  const TokenExists({required this.token});

  @override
  List<Object> get props => [token];
}

class TokenEmpty extends TokenState {}