import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import '../../../data/models/user/user_response_model.dart';

@immutable
abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterStateInitial extends RegisterState {}

class RegisterStateLoading extends RegisterState {}

class RegisterStateSuccess extends RegisterState {
  final User userModel;
  RegisterStateSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class RegisterStateFailure extends RegisterState {

  final String errorMessage;
  RegisterStateFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}