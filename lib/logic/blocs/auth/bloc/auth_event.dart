part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends AuthEvent {
  final SignUpRequest request;

  const SignupEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ResendVerificationEvent extends AuthEvent {
  final String email;

  const ResendVerificationEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class VerifyEmailEvent extends AuthEvent {
  final String token;

  const VerifyEmailEvent({required this.token});

  @override
  List<Object> get props => [token];
}
