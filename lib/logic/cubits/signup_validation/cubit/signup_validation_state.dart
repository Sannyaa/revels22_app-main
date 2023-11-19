part of 'signup_validation_cubit.dart';

@immutable
abstract class SignupValidationState extends Equatable {}

class SignupValidationInitial extends SignupValidationState {
  @override
  List<Object> get props => [];
}

class SignupValidationSuccess extends SignupValidationState {
  final SignUpRequest signUpRequest;

  SignupValidationSuccess({required this.signUpRequest});

  @override
  List<Object> get props => [signUpRequest];
}

class SignupValidationFailure extends SignupValidationState {
  final Map<String, dynamic> error;

  SignupValidationFailure({required this.error});

  @override
  List<Object> get props => [error];
}