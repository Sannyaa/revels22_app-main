import 'package:equatable/equatable.dart';

class SignUpRequest extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String mobileNumber;
  final String registrationNumber;
  final String college;
  final String course;

  const SignUpRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.mobileNumber,
    required this.registrationNumber,
    required this.college,
    required this.course,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'mobileNumber': mobileNumber,
        'registrationNumber': registrationNumber,
        'college': college,
        'course': course,
      };

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
        name,
        mobileNumber,
        registrationNumber,
        college,
        course,
      ];
}