import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mitrevels22/data/models/sign_up_request.dart';

part 'signup_validation_state.dart';

class SignupValidationCubit extends Cubit<SignupValidationState> {
  SignupValidationCubit() : super(SignupValidationInitial());

  void validate(SignUpRequest request) {
    if (request.name.isEmpty) {
      emit(SignupValidationFailure(error: const {'name': 'Name is required'}));
    } else if (request.email.isEmpty) {
      emit(
          SignupValidationFailure(error: const {'email': 'Email is required'}));
    } else if (request.password.isEmpty) {
      emit(SignupValidationFailure(
          error: const {'password': 'Password is required'}));
    } else if (request.password != request.confirmPassword) {
      emit(SignupValidationFailure(
          error: const {'confirmPassword': 'Passwords do not match'}));
    } else if (request.mobileNumber.isEmpty) {
      emit(SignupValidationFailure(
          error: const {'mobileNumber': 'Phone is required'}));
    } else if (request.mobileNumber.length != 10) {
      emit(SignupValidationFailure(
          error: const {'mobileNumber': 'Phone number must be 10 digits'}));
    } else if (request.course.isEmpty) {
      emit(SignupValidationFailure(
          error: const {'course': 'Course is required'}));
    } else if (request.college.isEmpty) {
      emit(SignupValidationFailure(
          error: const {'college': 'Please select your college'}));
    } else if (request.registrationNumber.isEmpty) {
      emit(SignupValidationFailure(error: const {
        'registrationNumber': 'Registration Number is required'
      }));
    } else {
      emit(SignupValidationSuccess(signUpRequest: request));
    }
  }

  void addErrors(Map<String, dynamic> error) {
    return emit(SignupValidationFailure(error: error));
  }
}