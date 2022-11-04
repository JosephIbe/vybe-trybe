import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';

import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';

import 'package:trybe_one_mobile/presentation/blocs/forgot_password/forgot_password_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/forgot_password/forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {

  final UserRepository _userRepository;

  ForgotPasswordBloc({required UserRepository repository})
    : _userRepository = repository,
    super(ForgotPasswordStateInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if(event is SendResetPasswordCode){
      yield* _mapSendResetPasswordCodeToState(event);
    }

    // if(event is CreateNewPassword){
    //   yield* _mapCreateNewPasswordToState(event);
    // }
  }

  Stream<ForgotPasswordState> _mapSendResetPasswordCodeToState(SendResetPasswordCode event) async* {
    yield ForgotPasswordStateLoading();
    try{
      final response = await _userRepository.forgotPassword(event.body);

      if(response != null){
        yield ForgotPasswordStateSuccess(response: response);
      } else {
        yield ForgotPasswordStateFailure(errorMessage: 'Unable to process your request at this time');
      }
    } on SocketException catch(e) {
      yield ForgotPasswordStateFailure(errorMessage: e.message);
    }
    catch (err) {
      yield ForgotPasswordStateFailure(errorMessage: 'Unable to process your request at this time');
    }

  }

  // Stream<ForgotPasswordState> _mapCreateNewPasswordToState(CreateNewPassword event) async* {}

}