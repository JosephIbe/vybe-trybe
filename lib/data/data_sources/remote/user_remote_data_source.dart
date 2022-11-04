import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import '../../models/user/user_response_model.dart';

abstract class UserRemoteDataSource {

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

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  final APIClient client;
  const UserRemoteDataSourceImpl({required this.client});

  @override
  Future<Object?> loginUser(Map<String, dynamic> body) async {
    try {
      final response = await client.postAuthData(
          pathSegment: APIConstants.LOGIN_SEGMENT,
          body: body
      );
      // print('login response in urds is:\n$response');
      return response;
    } catch (e){
      return e;
    }
  }

  @override
  Future<User?> registerUser(Map<String, dynamic> body) async {
    final response = await client.postAuthData(
        pathSegment: APIConstants.REGISTER_SEGMENT,
        body: body
    );
    final userModel = UserResponseModel.fromJson(response);

    var box = Hive.box(DBConstants.userBoxName);
    box.put(DBConstants.id, userModel.data!.user!.id);
    box.put(DBConstants.email, userModel.data!.user!.email);
    box.put(DBConstants.iSCompleteOnBoarding, userModel.data!.user!.isCompleteOnboarding);
    box.put(DBConstants.onBoardingStep, userModel.data!.user!.onboardingStep);
    box.put(DBConstants.isVerified, userModel.data!.user!.isVerified);
    // box.put(DBConstants., userModel.data!.user!.);

    return userModel.data!.user;
  }

  @override
  Future<UserResponseModel?> verifyUserEmail(Map<String, dynamic> body) async {
    final response = await client.postAuthData(
        pathSegment: APIConstants.VERIFY_EMAIL_SEGMENT,
        body: body
    );
    final userResponseModel = UserResponseModel.fromJson(response);
    return userResponseModel;
  }

  @override
  Future<User?> resendVerificationCode(Map<String, dynamic> body) async {
    final response = await client.postAuthData(
        pathSegment: APIConstants.RESEND_CONFIRMATION_CODE_SEGMENT,
        body: body
    );
    final userResponseModel = UserResponseModel.fromJson(response);
    final user = userResponseModel.data!.user;
    return user;
  }

  @override
  Future<dynamic> forgotPassword(Map<String, dynamic> body) async {
    final forgotPasswordResponse = await client.postAuthData(
        pathSegment: APIConstants.FORGOT_PASSWORD_SEGMENT,
        body: body
    );
    return forgotPasswordResponse;
  }

  @override
  Future<User?> verifyPasswordResetCode(Map<String, dynamic> body) async {

    var box = Hive.box(DBConstants.userBoxName);

    final response = await client.verifyPasswordResetCode(
      pathSegment: APIConstants.VERIFY_PASSWORD_RESET_CODE_SEGMENT,
      body: body,
    );
    final user = UserResponseModel.fromJson(response).data!.user;

    box.put(DBConstants.id, user!.id);

    return user;
  }

  @override
  Future<dynamic> createNewPassword(Map<String, dynamic> body) async {
    final response = await client.postAuthData(
        pathSegment: APIConstants.RESET_PASSWORD_SEGMENT,
        body: body
    );
    return response;
  }

  @override
  Future<dynamic> submitLifeUpdate(dynamic body) async {
    print('body in urds:\n$body');
    final response = await client.submitLifeUpdateType(
      pathSegment: APIConstants.LIFE_UPDATE_SEGMENT,
      body: body,
    );
    print('response in urds:\n $response');
    print(response);
    return response;
  }

  @override
  Future<UserModel> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

}