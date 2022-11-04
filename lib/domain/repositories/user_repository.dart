// import 'package:dio/dio.dart';
// import 'package:trybe_one_mobile/data/models/user/user_model.dart';
// import '../../data/models/user/user_response_model.dart';
//
// abstract class UserRepository {
//   Future<UserModel?> loginUser(Map<String, dynamic> body);
//   // Future<UserResponseModel?> loginUser(Map<String, dynamic> body);
//   // Future<dynamic> loginUser(Map<String, dynamic> body);
//   // Future<Map<dynamic, dynamic>>loginUser(Map<String, dynamic> body);
//
//   Future<UserModel?> registerUser(Map<String, dynamic> body);
//   Future<UserResponseModel?> verifyUserEmail(Map<String, dynamic> body);
//   Future<UserModel?> resendVerificationCode(Map<String, dynamic> body);
//   Future<dynamic> forgotPassword(Map<String, dynamic> body);
//
//   Future<UserModel?> verifyPasswordResetCode(Map<String, dynamic> body);
//   Future<dynamic> createNewPassword(Map<String, dynamic> body);
//
//   Future<dynamic> submitLifeUpdate(Map<String, dynamic> body);
//
//   Future<UserModel> getCurrentUser();
//   Future<void> logOut();
//
// }

import 'package:dio/dio.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import '../../data/models/user/user_response_model.dart';

abstract class UserRepository {
  Future<Object?> loginUser(Map<String, dynamic> body);
  Future<User?> registerUser(Map<String, dynamic> body);
  Future<UserResponseModel?> verifyUserEmail(Map<String, dynamic> body);
  Future<User?> resendVerificationCode(Map<String, dynamic> body);
  Future<dynamic> forgotPassword(Map<String, dynamic> body);

  Future<User?> verifyPasswordResetCode(Map<String, dynamic> body);
  Future<dynamic> createNewPassword(Map<String, dynamic> body);

  Future<dynamic> submitLifeUpdate(Map<String, dynamic> body);

  Future<UserModel> getCurrentUser();
  Future<void> logOut();
}