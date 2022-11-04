import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';
import 'package:trybe_one_mobile/presentation/blocs/create_password/create_password_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/create_password/create_password_state.dart';

class CreatePasswordBloc extends Bloc<CreatePasswordEvent, CreateNewPasswordState> {

  UserRepository _repository;

  CreatePasswordBloc({required UserRepository repository})
    : _repository = repository,
    super(CreateNewPasswordStateInitial());

  @override
  Stream<CreateNewPasswordState> mapEventToState(
      CreatePasswordEvent event) async* {
    if(event is SubmitNewPassword) {
      yield* _mapSubmitNewPasswordToState(event);
    }
  }

  Stream<CreateNewPasswordState> _mapSubmitNewPasswordToState(SubmitNewPassword event) async* {
    yield CreateNewPasswordStateLoading();
    try {
      final response = await _repository.createNewPassword(event.body);
      if(response != null){
        yield CreateNewPasswordStateSuccess(model: response);
      } else {
        yield CreateNewPasswordStateFailure(errorMessage: 'Unable to process your request at the moment');
      }
    } on SocketException catch (e) {
      yield CreateNewPasswordStateFailure(errorMessage: e.message);
    } catch (err){
      print(err);
      yield CreateNewPasswordStateFailure(errorMessage: 'Error Completing Your Request, Try Again!');
    }
  }

}