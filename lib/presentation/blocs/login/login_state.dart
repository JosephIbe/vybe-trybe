import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trybe_one_mobile/data/models/error_response_model.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import '../../../data/models/user/user_response_model.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  // final User? userModel;
  final Object? userModel;
  LoginStateSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class LoginStateFailure extends LoginState {

  final dynamic errorMessage;
  LoginStateFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage!];

}