import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:trybe_one_mobile/data/data_sources/remote/user_remote_data_source.dart';
import 'package:trybe_one_mobile/data/models/error_response_model.dart';
import 'package:trybe_one_mobile/data/models/user/user_response_model.dart';
import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';

import 'package:trybe_one_mobile/presentation/blocs/login/login_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final UserRepository _userRepository;

  LoginBloc({required UserRepository repository})
      : _userRepository = repository,
        super(LoginStateInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginWithEmail) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(LoginWithEmail event) async* {
    yield LoginStateLoading();
    try {
      dynamic response = await _userRepository.loginUser(event.body);
      // print(response.toString());

       final modelledResponse = UserResponseModel.fromJson(response);
       print('bloc modelledResponse:\n$modelledResponse');
       print(modelledResponse.data);
       print(modelledResponse.message);
       print(modelledResponse.status);

      if(modelledResponse.status != 'error'){
        // print('bloc response:\n$response');
        yield LoginStateSuccess(userModel: modelledResponse.data?.user);
      } else {
        // print('bloc response:\n$response');
        yield LoginStateFailure(errorMessage: ErrorResponseModel.fromJson(response).message);
      }
    } on SocketException catch (e) {
      print(e);
      yield LoginStateFailure(errorMessage: 'Check your internet connection');
    }
  }

  // Stream<LoginState> _mapLoginWithEmailToState(LoginWithEmail event) async* {
  //   yield LoginStateLoading();
  //   try {
  //     final response = await _userRepository.loginUser(event.body);
  //     // UserResponseModel? responseModel = UserResponseModel.fromJson(response);
  //     print('login bloc urm:\n $response');
  //     if(response == null){
  //       print('response in login bloc:\n $response');
  //       // yield LoginStateSuccess(userResponseModel: response);
  //       print('erm message:\n ${ErrorResponseModel.fromJson(response).message}');
  //       yield LoginStateFailure(errorMessage: ErrorResponseModel.fromJson(response).message);
  //     } else {
  //       // yield LoginStateFailure(errorMessage: 'Could Not Login at the Moment!');
  //       yield LoginStateSuccess(userResponseModel: response);
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //     yield LoginStateFailure(errorMessage: e.toString());
  //   }
  // }

}