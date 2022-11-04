import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:trybe_one_mobile/data/models/user/user_response_model.dart';

@immutable
abstract class VerifyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyStateInitial extends VerifyState {}

class VerifyStateLoading extends VerifyState {}

class VerifyStateSuccess extends VerifyState {
  final UserResponseModel? userModel;
  VerifyStateSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];

}

class ResendVerificationCodeStateSuccess extends VerifyState {
  final User? userModel;
  ResendVerificationCodeStateSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class ResendVerificationCodeStateFailure extends VerifyState {
  final String? errorMessage;
  ResendVerificationCodeStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class VerifyStateFailure extends VerifyState {
  final String errorMessage;
  VerifyStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class VerifyResendPasswordCodeStateSuccess extends VerifyState {

  final User? userModel;
  VerifyResendPasswordCodeStateSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];

}

class VerifyResendPasswordCodeStateFailure extends VerifyState {

  final String errorMessage;
  VerifyResendPasswordCodeStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}