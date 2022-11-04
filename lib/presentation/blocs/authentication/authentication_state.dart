import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user/user_response_model.dart';

@immutable
abstract class AuthenticationState extends Equatable{
  @override
  List<Object> get props => [];
}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateLoading extends AuthenticationState {}

class AuthenticationStateUnAuthenticated extends AuthenticationState {}

class AuthenticationStateAuthenticated extends AuthenticationState {

  final dynamic user;
  AuthenticationStateAuthenticated({@required this.user, });

  @override
  List<Object> get props => [user, ];

}

class OnBoardingInComplete extends AuthenticationState {
  final int onBoardingStep;
  OnBoardingInComplete({required this.onBoardingStep});

  @override
  List<Object> get props => [onBoardingStep];

}

class AuthenticationStateFailure extends AuthenticationState {
  final String errorMessage;
  AuthenticationStateFailure({required this.errorMessage});
}