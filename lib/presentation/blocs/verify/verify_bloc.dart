import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';
import 'package:trybe_one_mobile/presentation/blocs/verify/verify_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/verify/verify_state.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/verify_password_reset_code.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {

  final UserRepository _userRepository;

  VerifyBloc({required UserRepository repository})
    : _userRepository = repository,
    super(VerifyStateInitial());

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event) async* {
    if(event is SubmitVerificationCode){
      yield* _mapSubmitVerificationCodeToState(event);
    }
    if(event is ResendVerificationCode){
      yield* _mapResendVerificationCodeToState(event);
    }
    if(event is VerifyPasswordResetCodeSent) {
      yield* _mapVerifyPasswordResetCodeSentToState(event);
    }
  }

  Stream<VerifyState> _mapSubmitVerificationCodeToState(SubmitVerificationCode event) async* {
    yield VerifyStateLoading();
    try {
      final user = await _userRepository.verifyUserEmail(event.body);
      // print(user);
      if(user != null){
        yield VerifyStateSuccess(userModel: user);
      } else {
        yield VerifyStateFailure(errorMessage: 'Unable to process your request at this time');
      }
    } on SocketException catch (e) {
      yield VerifyStateFailure(errorMessage: e.message);
    } catch (err){
      print(err);
      yield VerifyStateFailure(errorMessage: 'Error Completing Your Request, Try Again!');
    }
  }

  Stream<VerifyState> _mapResendVerificationCodeToState(ResendVerificationCode event) async* {
    try {
      final user = await _userRepository.resendVerificationCode(event.body);
      print(user);
      if(user != null){
        yield ResendVerificationCodeStateSuccess(userModel: user);
      } else {
        yield ResendVerificationCodeStateFailure(errorMessage: 'Unable to process your request at this time');
      }
    } on SocketException catch (e) {
      yield ResendVerificationCodeStateFailure(errorMessage: e.message);
    } catch (err){
      print(err);
      yield ResendVerificationCodeStateFailure(errorMessage: 'Error Completing Your Request, Try Again!');
    }
  }

  Stream<VerifyState> _mapVerifyPasswordResetCodeSentToState(VerifyPasswordResetCodeSent event) async* {
    try {
      final user = await _userRepository.verifyPasswordResetCode(event.body);
      print(user);
      if(user != null){
        yield VerifyResendPasswordCodeStateSuccess(userModel: user);
      } else {
        yield VerifyResendPasswordCodeStateFailure(errorMessage: 'Unable to process your request at this time');
      }
    } on SocketException catch (e) {
      yield VerifyResendPasswordCodeStateFailure(errorMessage: e.message);
    } catch (err){
      print(err);
      yield ResendVerificationCodeStateFailure(errorMessage: 'Error Completing Your Request, Try Again!');
    }
  }

}