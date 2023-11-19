import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:mitrevels22/config/apis/user_auth_profile_apis.dart';
import 'package:mitrevels22/data/models/sign_up_request.dart';
import 'package:dio/dio.dart';
import 'package:mitrevels22/data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignupEvent>((event, emit) async {
      final CancelToken cancelToken = CancelToken();
      emit(AuthLoading(cancelToken: cancelToken));
      final dio = Dio();
      try {
        final response = await dio.post(registerUser(),
            data: jsonEncode(event.request), cancelToken: cancelToken);
        if (response.statusCode == 200) {
          final body = response.data;
          final bool success = body['success'];
          if (success) {
            return emit(SignupSuccess(request: event.request));
          } else {
            try {
              final msg = body['msg'] as List<dynamic>;
              return emit(
                SignupError(
                  validationErrors: msg.reduce(
                    (value, element) => value..addAll(element),
                  ),
                ),
              );
            } catch (e) {
              final msg = body['msg'] as String;
              return emit(SignupError(error: msg));
            }
          }
        } else {
          return emit(const SignupError(error: "Error while signing up"));
        }
      } on SocketException {
        return emit(
          const SignupError(
              error: "Please check your internet connection and try again"),
        );
      } on DioError catch (e) {
        if (e.response?.statusCode == 400) {
          final body = e.response?.data;
          final msg = body['msg'] as String;
          return emit(SignupError(error: msg));
        }
      } catch (e) {
        return emit(const SignupError(error: "Unknown error occured"));
      }
    });

    on<LoginEvent>((event, emit) async {
      final CancelToken cancelToken = CancelToken();
      emit(AuthLoading(cancelToken: cancelToken));
      final dio = Dio();
      try {
        final response = await dio.post(
          loginUser(),
          data: jsonEncode({'email': event.email, 'password': event.password}),
          cancelToken: cancelToken,
        );
        print(response.data);
        if (response.statusCode == 200) {
          final body = response.data;
          final bool success = body['success'];
          if (success) {
            final user = User.fromJson(body['data']);

            return emit(LoginSuccess(user: user));
          } else {
            try {
              final msg = body['msg'] as List<dynamic>;
              return emit(
                LoginError(
                  validationErrors: msg.reduce(
                    (value, element) => value..addAll(element),
                  ),
                ),
              );
            } catch (e) {
              final msg = body['msg'] as String;
              return emit(LoginError(error: msg));
            }
          }
        } else {
          return emit(const LoginError(error: "Error while logging in"));
        }
      } on DioError catch (e) {
        if (e.response?.statusCode == 401) {
          final body = e.response?.data;
          final msg = body['msg'] as String;
          return emit(LoginError(error: msg));
        } else if (e.response?.statusCode == 403) {
          final body = e.response?.data;
          final msg = body['msg'] as String;
          return emit(LoginError(error: msg));
        } else {
          return emit(const LoginError(error: "Error while logging in"));
        }
      } catch (e) {
        print(e);
        return emit(const LoginError(error: "Error while logging in"));
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      final CancelToken cancelToken = CancelToken();
      emit(AuthLoading(cancelToken: cancelToken));
      final dio = Dio();
      try {
        final response = await dio.post(
          forgetPassword(),
          data: jsonEncode({'email': event.email}),
          cancelToken: cancelToken,
        );
        if (response.statusCode == 200) {
          final body = response.data;
          final bool success = body['success'];
          if (success) {
            final msg = body['msg'] as String;
            return emit(ForgotPasswordSuccess(message: msg));
          } else {
            try {
              final msg = body['msg'] as String;
              return emit(ForgotPasswordError(error: msg));
            } catch (e) {
              return emit(const ForgotPasswordError(
                  error: "Error while sending email"));
            }
          }
        } else {
          return emit(
              const ForgotPasswordError(error: "Error while sending email"));
        }
      } on DioError catch (e) {
        final body = e.response?.data;
        final msg = body['msg'] as String;
        return emit(ForgotPasswordError(error: msg));
      } catch (e) {
        return emit(
            const ForgotPasswordError(error: "Error while sending email"));
      }
    });

    on<ResendVerificationEvent>((event, emit) async {
      final CancelToken cancelToken = CancelToken();
      emit(AuthLoading(cancelToken: cancelToken));
      final dio = Dio();
      try {
        final response = await dio.post(
          resendVerification(),
          data: jsonEncode({"email": event.email}),
          cancelToken: cancelToken,
        );
        if (response.statusCode == 200) {
          final body = response.data;
          final bool success = body['success'];
          if (success) {
            final msg = body['msg'] as String;
            return emit(ResendVerificationSuccess(message: msg));
          } else {
            try {
              final msg = body['msg'] as String;
              return emit(ResendVerificationError(error: msg));
            } catch (e) {
              return emit(const ResendVerificationError(
                  error: "Error while sending email"));
            }
          }
        } else {
          return emit(const ResendVerificationError(
              error: "Error while sending email"));
        }
      } on DioError catch (e) {
        final body = e.response?.data;
        final msg = body['msg'] as String;
        return emit(ResendVerificationError(error: msg));
      } catch (e) {
        return emit(
            const ResendVerificationError(error: "Error while sending email"));
      }
    });
    on<VerifyEmailEvent>((event, emit) async {
      final CancelToken cancelToken = CancelToken();
      emit(AuthLoading(cancelToken: cancelToken));
      final dio = Dio();
      try {
        final response = await dio.get(verifyEmail(event.token));
        if (response.statusCode == 200) {
          final body = response.data;
          final bool success = body['success'];
          if (success) {
            final msg = body['msg'] as String;
            return emit(VerifyEmailSuccess(message: msg));
          } else {
            try {
              final msg = body['msg'] as String;
              return emit(VerifyEmailError(error: msg));
            } catch (e) {
              return emit(
                  const VerifyEmailError(error: "Error while verifying email"));
            }
          }
        } else {
          return emit(
              const VerifyEmailError(error: "Error while verifying email"));
        }
      } on DioError catch (e) {
        final body = e.response?.data;
        final msg = body['msg'] as String;
        return emit(VerifyEmailError(error: msg));
      } catch (e) {
        return emit(
            const VerifyEmailError(error: "Error while verifying email"));
      }
    });
  }
}
