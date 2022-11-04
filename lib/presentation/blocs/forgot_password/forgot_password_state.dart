import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import '../../../data/models/user/user_response_model.dart';

@immutable
abstract class ForgotPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordStateInitial extends ForgotPasswordState {}

class ForgotPasswordStateLoading extends ForgotPasswordState {}

class ForgotPasswordStateSuccess extends ForgotPasswordState {

  final dynamic response;
  ForgotPasswordStateSuccess({required this.response});

  @override
  List<Object?> get props => [response];

}

class ForgotPasswordStateFailure extends ForgotPasswordState {

  final String errorMessage;
  ForgotPasswordStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}

class CreateNewPasswordStateInitial extends ForgotPasswordState {}

class CreateNewPasswordStateLoading extends ForgotPasswordState {}

class CreateNewPasswordStateSuccess extends ForgotPasswordState {}

class CreateNewPasswordStateFailure extends ForgotPasswordState {

  final String errorMessage;
  CreateNewPasswordStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}