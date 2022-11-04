import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';

import 'package:trybe_one_mobile/presentation/blocs/submit_life_update/submit_life_update_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/submit_life_update/submit_life_update_state.dart';

class SubmitLifeUpdateBloc
    extends Bloc<SubmitLifeUpdateEvent, SubmitLifeUpdateState> {

  UserRepository _userRepository;

  SubmitLifeUpdateBloc({required UserRepository repository})
    : _userRepository = repository
    , super(SubmitLifeUpdateStateInitial());

  @override
  Stream<SubmitLifeUpdateState> mapEventToState(
      SubmitLifeUpdateEvent event) async* {
    if(event is SubmitStudentLifeUpdate){
      yield* _mapSubmitStudentLifeUpdateToState(event);
    }
    if(event is SubmitCorpMemberLifeUpdate){
      yield* _mapSubmitCorpMemberLifeUpdateToState(event);
    }
    if(event is SubmitEmployedAndSelfEmployedLifeUpdate) {
      yield* _mapSubmitEmployedAndSelfEmployedLifeUpdateToState(event);
    }
  }

  Stream<SubmitLifeUpdateState> _mapSubmitStudentLifeUpdateToState(SubmitStudentLifeUpdate event) async* {
    yield SubmitLifeUpdateStateLoading();

    try{
      final response = await _userRepository.submitLifeUpdate(event.body);

      if(response != null){
        yield StudentLifeUpdateStateSuccess(response: response);
      } else {
        yield StudentLifeUpdateStateFailure(errorMessage: 'Unable to process your request at this time');
      }
    } on SocketException catch(e) {
      yield StudentLifeUpdateStateFailure(errorMessage: e.message);
    }
    catch (err) {
      yield StudentLifeUpdateStateFailure(errorMessage: 'Unable to process your request at this time');
    }

  }

  Stream<SubmitLifeUpdateState> _mapSubmitCorpMemberLifeUpdateToState(SubmitCorpMemberLifeUpdate event) async* {
    yield SubmitLifeUpdateStateLoading();

    try{
      final response = await _userRepository.submitLifeUpdate(event.body);

      if(response != null){
        // print(response);
        yield CorpMemberLifeUpdateStateSuccess(response: response);
      } else {
        yield CorpMemberLifeUpdateStateFailure(errorMessage: 'Unable to process your request at this time');
      }
    } on SocketException catch(e) {
      yield CorpMemberLifeUpdateStateFailure(errorMessage: e.message);
    }
    catch (err) {
      yield CorpMemberLifeUpdateStateFailure(errorMessage: 'Unable to process your request at this time');
    }

  }

  Stream<SubmitLifeUpdateState> _mapSubmitEmployedAndSelfEmployedLifeUpdateToState(SubmitEmployedAndSelfEmployedLifeUpdate event) async* {
    yield SubmitLifeUpdateStateLoading();

    try{
      final response = await _userRepository.submitLifeUpdate(event.body);

      if(response != null){
        yield EmployedLifeUpdateStateSuccess(response: response);
      } else {
        yield EmployedLifeUpdateStateFailure(errorMessage: 'Unable to process your request at this time');
      }
    } on SocketException catch(e) {
      yield EmployedLifeUpdateStateFailure(errorMessage: e.message);
    }
    catch (err) {
      yield EmployedLifeUpdateStateFailure(errorMessage: 'Unable to process your request at this time');
    }

  }

}