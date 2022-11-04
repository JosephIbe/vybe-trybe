import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class CreateNewPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNewPasswordStateInitial extends CreateNewPasswordState {}

class CreateNewPasswordStateLoading extends CreateNewPasswordState {}

class CreateNewPasswordStateSuccess extends CreateNewPasswordState {

  final dynamic model;
  CreateNewPasswordStateSuccess({required this.model});

  @override
  List<Object?> get props => [model];

}

class CreateNewPasswordStateFailure extends CreateNewPasswordState {

  final String errorMessage;
  CreateNewPasswordStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}