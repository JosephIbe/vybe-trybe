import 'dart:async';

import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';
import 'package:trybe_one_mobile/presentation/blocs/authentication/authentication_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/authentication/authentication_state.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _repository;
  AuthenticationBloc({ required UserRepository repository})
      : _repository = repository,
        super(AuthenticationStateInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {

    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    }

    if(event is UserSignedUp){
      yield* _mapUserSignedUpToState(event);
    }

    if(event is UserLoggedIn){
      yield* _mapUserLoggedInToState(event);
    }

    // if(event is UserLoggedOut){
    //   await _repository.deleteTokens(event.accessToken, event.refreshToken);
    //   yield* _mapUserLoggedOutToState(event);
    // }

  }

  Stream<AuthenticationState> _mapAppStartedToState(AppStarted event) async* {
    yield AuthenticationStateLoading();
    try{

    }catch(err){
      print(err);
      yield AuthenticationStateFailure(errorMessage: err.toString());
    }
  }

  Stream<AuthenticationState> _mapUserSignedUpToState(UserSignedUp event) async* {
    yield AuthenticationStateAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthenticationStateAuthenticated(user: event.user);
  }

  // Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
  //   await _repository.logOut();
  //   yield AuthenticationStateUnAuthenticated();
  // }

}