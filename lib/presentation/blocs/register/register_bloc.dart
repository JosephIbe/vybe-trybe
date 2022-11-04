import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';

import 'package:trybe_one_mobile/presentation/blocs/register/register_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final UserRepository _userRepository;

  RegisterBloc({required UserRepository repository})
     : _userRepository = repository,
     super(RegisterStateInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if(event is RegisterWithEmail) {
      yield* _mapRegisterWithEmailToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterWithEmailToState(RegisterWithEmail event) async* {
    // yield RegisterStateLoading();
    try {
      final user = await _userRepository.registerUser(event.body);
      if(user != null){
        yield RegisterStateSuccess(userModel: user);
      } else {
        yield RegisterStateFailure(errorMessage: 'Unable to process your request at this time');
      }
      } on SocketException catch (e) {
      print(e);
      yield RegisterStateFailure(errorMessage: e.message);
    }
    // } catch (err){
    //   print(err);
    //   yield RegisterStateFailure(errorMessage: 'Error Completing Your Request, Try Again!');
    // }
  }

}