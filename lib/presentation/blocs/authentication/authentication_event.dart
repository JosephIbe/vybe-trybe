import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import '../../../data/models/user/user_response_model.dart';

@immutable
abstract class AuthenticationEvent extends Equatable{

  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {

  // final String accessToken;
  // final String refreshToken;
  //
  // const AppStarted({@required this.accessToken, @required this.refreshToken});

  // @override
  // List<Object> get props => [accessToken, refreshToken];

}

class UserSignedUp extends AuthenticationEvent {
  final UserModel user;
  // final String accessToken;
  // final String refreshToken;

  const UserSignedUp({
    required this.user,
  });

  @override
  List<Object> get props => [user, ];

}

class UserLoggedIn extends AuthenticationEvent {
  final UserModel user;

  const UserLoggedIn({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

// class UserLoggedOut extends AuthenticationEvent {
//
//   final String accessToken;
//   final String refreshToken;
//
//   const UserLoggedOut({
//     @required this.accessToken,
//     @required this.refreshToken,
//   });
//
//   @override
//   List<Object> get props => [accessToken, refreshToken];
// }