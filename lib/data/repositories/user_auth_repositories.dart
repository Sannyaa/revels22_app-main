import 'package:dio/dio.dart';
import 'package:mitrevels22/config/apis/event_apis.dart';
import '../../config/apis/user_auth_profile_apis.dart';

class UserRepository {
  Future<dynamic> register(
      String name,
      String email,
      String password,
      String mobileNumber,
      String registrationNumber,
      String branch,
      String college,
      String state) async {
    return await Dio().post(registerUser(), data: {
      "name": name,
      "email": email,
      "password": password,
      "mobileNumber": mobileNumber,
      "registrationNumber": registrationNumber,
      "branch": branch,
      "college": college,
      "state": state
    });
  }

  Future<dynamic> login(String email, String password) async {
    return await Dio()
        .post(loginUser(), data: {"email": email, "password": password});
  }

  Future<Response<dynamic>> logout(String token) async {
    Dio dio = Dio(
      BaseOptions(headers: {'Authorization': token}),
    );
    return await dio.get(logoutUser());
  }

  Future<dynamic> resendVerificationLink(String email) async {
    return await Dio().post(resendVerification(), data: {"email": email});
  }

  Future<dynamic> forgetPasswordLink(String email) async {
    return await Dio().post(forgetPassword(), data: {"email": email});
  }

  Future<Response> forgetPasswordVerification(
      String email, String token, String newPassword) async {
    return await Dio().post(forgetPasswordVerify(),
        data: {"email": email, "token": token, "newPassword": newPassword});
  }

  Future<dynamic> getUserFromTokenMethod(String token) async {
    Dio dio = Dio(
      BaseOptions(headers: {'Authorization': token}),
    );
    return await dio.get(getUserFromToken());
  }

  Future<Response> getRegisteredEvents(String token) async {
    return await Dio().get(viewRegisteredEvent(),
        options: Options(headers: {"authorization": token}));
  }
}
