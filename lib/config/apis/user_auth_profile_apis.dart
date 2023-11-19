import '../settings/settings.dart';

String registerUser() => "$baseUrl/api/user/register";
String loginUser() => "$baseUrl/api/user/login";
String logoutUser() => "$baseUrl/api/user/logout";
String verifyEmail(String token) => "$baseUrl/api/user/verify/$token";
String resendVerification() => "$baseUrl/api/user/resendlink";
String forgetPassword() => "$baseUrl/api/user/forgetpass";
String forgetPasswordVerify() => "$baseUrl/api/user/forgetpass/verify";
String updateAccommodation() => "$baseUrl/api/user/update/accommodation";
String getUserFromToken() => "$baseUrl/api/user/getuser";
String getCollegeList() => "$baseUrl/api/colleges";
