part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  final CancelToken cancelToken;

  const AuthLoading({required this.cancelToken});

  @override
  List<Object?> get props => [cancelToken];
}

class SignupSuccess extends AuthState {
  final SignUpRequest request;

  const SignupSuccess({required this.request});

  @override
  List<Object?> get props => [request];
}

class SignupError extends AuthState {
  final String? error;
  final Map? validationErrors;

  const SignupError({this.error, this.validationErrors});

  @override
  List<Object?> get props => [error, validationErrors];
}

class LoginSuccess extends AuthState {
  final User user;

  const LoginSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginError extends AuthState {
  final String? error;
  final Map? validationErrors;

  const LoginError({this.error, this.validationErrors});

  @override
  List<Object?> get props => [error, validationErrors];
}

class ForgotPasswordSuccess extends AuthState {
  final String? message;

  const ForgotPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ForgotPasswordError extends AuthState {
  final String? error;

  const ForgotPasswordError({this.error});

  @override
  List<Object?> get props => [error];
}

class ResendVerificationSuccess extends AuthState {
  final String message;

  const ResendVerificationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ResendVerificationError extends AuthState {
  final String error;

  const ResendVerificationError({required this.error});

  @override
  List<Object> get props => [error];
}

class VerifyEmailSuccess extends AuthState {
  final String message;

  const VerifyEmailSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class VerifyEmailError extends AuthState {
  final String error;

  const VerifyEmailError({required this.error});

  @override
  List<Object> get props => [error];
}
