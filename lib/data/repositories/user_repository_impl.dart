// import 'package:trybe_one_mobile/data/core/db_constants.dart';
// import 'package:trybe_one_mobile/data/data_sources/remote/user_remote_data_source.dart';
// import 'package:trybe_one_mobile/data/models/user/user_model.dart';
// import '../models/user/user_response_model.dart';
// import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';
//
// import 'package:hive/hive.dart';
//
// class UserRepositoryImpl implements UserRepository {
//
//   final UserRemoteDataSource dataSource;
//   const UserRepositoryImpl({required this.dataSource});
//
//   @override
//   Future<UserModel?> loginUser(Map<String, dynamic> body) async {
//     final user = await dataSource.loginUser(body);
//     print('login response in urds is:\n$user');
//
//     var box = Hive.box(DBConstants.userBoxName);
//
//     box.put(DBConstants.onBoardingStep, user!.onboardingStep);
//
//     return user;
//   }
//
//   @override
//   Future<UserModel?> registerUser(Map<String, dynamic> body) async {
//     final user = await dataSource.registerUser(body);
//
//     print('register response:\n$user');
//
//     // var box = Hive.box(DBConstants.userBoxName);
//     //
//     // box.put(DBConstants.onBoardingStep, user!.onboardingStep);
//     // box.put(DBConstants.id, user.id);
//     // box.put(DBConstants.isAddressVerified, user.isAddressVerified);
//     // box.put(DBConstants.iSCompleteOnBoarding, user.isCompleteOnboarding);
//     // box.put(DBConstants.email, user.email);
//     // box.put(DBConstants.isVerified, user.isVerified);
//
//     return user;
//   }
//
//   @override
//   Future<UserResponseModel?> verifyUserEmail(Map<String, dynamic> body) async {
//
//     var box = Hive.box(DBConstants.userBoxName);
//
//     final verifiedUserResponse = await dataSource.verifyUserEmail(body);
//     box.put(DBConstants.JWTToken, verifiedUserResponse!.data!.token);
//
//     //todo save user fields locally
//
//     return verifiedUserResponse;
//   }
//
//   @override
//   Future<UserModel?> resendVerificationCode(Map<String, dynamic> body) async {
//     final resendCodeResponse = await dataSource.resendVerificationCode(body);
//     print('resendCodeResponse:\t\n$resendCodeResponse');
//     return resendCodeResponse;
//   }
//
//   @override
//   Future<dynamic> forgotPassword(Map<String, dynamic> body) async {
//     final forgotPasswordResponse = await dataSource.forgotPassword(body);
//     return forgotPasswordResponse;
//   }
//
//   @override
//   Future<UserModel?> verifyPasswordResetCode(Map<String, dynamic> body) async {
//     final response = await dataSource.verifyPasswordResetCode(body);
//     print(response);
//     return response;
//   }
//
//   @override
//   Future<dynamic> createNewPassword(Map<String, dynamic> body) async {
//     final response = await dataSource.createNewPassword(body);
//     return response;
//   }
//
//   @override
//   Future<dynamic> submitLifeUpdate(dynamic body) async {
//     final response = await dataSource.submitLifeUpdate(body);
//     // print(response);
//     return response;
//   }
//
//   @override
//   Future<UserModel> getCurrentUser() async {
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> logOut() {
//     // TODO: implement logOut
//     throw UnimplementedError();
//   }
//
// }

import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/data/data_sources/remote/user_remote_data_source.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import '../models/user/user_response_model.dart';
import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';

import 'package:hive/hive.dart';

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDataSource dataSource;
  const UserRepositoryImpl({required this.dataSource});

  @override
  Future<Object?> loginUser(Map<String, dynamic> body) async {
    final user = await dataSource.loginUser(body);
    // print('login response in urpimpl is:\n$user');

    // var box = Hive.box(DBConstants.userBoxName);
    // box.put(DBConstants.onBoardingStep, user!.onboardingStep);

    return user;
  }

  @override
  Future<User?> registerUser(Map<String, dynamic> body) async {
    final user = await dataSource.registerUser(body);

    // var box = Hive.box(DBConstants.userBoxName);
    //
    // box.put(DBConstants.onBoardingStep, user!.onboardingStep);
    // box.put(DBConstants.id, user.id);
    // box.put(DBConstants.isAddressVerified, user.isAddressVerified);
    // box.put(DBConstants.iSCompleteOnBoarding, user.isCompleteOnboarding);
    // box.put(DBConstants.email, user.email);
    // box.put(DBConstants.isVerified, user.isVerified);

    return user;
  }

  @override
  Future<UserResponseModel?> verifyUserEmail(Map<String, dynamic> body) async {

    var box = Hive.box(DBConstants.userBoxName);

    final verifiedUserResponse = await dataSource.verifyUserEmail(body);
    box.put(DBConstants.JWTToken, verifiedUserResponse!.data!.token);

    //todo save user fields locally

    return verifiedUserResponse;
  }

  @override
  Future<User?> resendVerificationCode(Map<String, dynamic> body) async {
    final resendCodeResponse = await dataSource.resendVerificationCode(body);
    print('resendCodeResponse:\t\n$resendCodeResponse');
    return resendCodeResponse;
  }

  @override
  Future<dynamic> forgotPassword(Map<String, dynamic> body) async {
    final forgotPasswordResponse = await dataSource.forgotPassword(body);
    return forgotPasswordResponse;
  }

  @override
  Future<User?> verifyPasswordResetCode(Map<String, dynamic> body) async {
    final response = await dataSource.verifyPasswordResetCode(body);
    print(response);
    return response;
  }

  @override
  Future<dynamic> createNewPassword(Map<String, dynamic> body) async {
    final response = await dataSource.createNewPassword(body);
    return response;
  }

  @override
  Future<dynamic> submitLifeUpdate(dynamic body) async {
    final response = await dataSource.submitLifeUpdate(body);
    // print(response);
    return response;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

}