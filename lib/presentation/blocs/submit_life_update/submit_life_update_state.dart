import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SubmitLifeUpdateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitLifeUpdateStateInitial extends SubmitLifeUpdateState {}

class SubmitLifeUpdateStateLoading extends SubmitLifeUpdateState {}

/**
 *  Student Life Update States
 * */

class StudentLifeUpdateStateSuccess extends SubmitLifeUpdateState {

  final Map<String, dynamic> response;
  StudentLifeUpdateStateSuccess({required this.response});

  @override
  List<Object?> get props => [response];

}

class StudentLifeUpdateStateFailure extends SubmitLifeUpdateState {
  final String errorMessage;
  StudentLifeUpdateStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}

/**
 *  Corp Member Life Update States
 * */

class CorpMemberLifeUpdateStateSuccess extends SubmitLifeUpdateState {

  final Map<String, dynamic> response;
  CorpMemberLifeUpdateStateSuccess({required this.response});

  @override
  List<Object?> get props => [response];

}

class CorpMemberLifeUpdateStateFailure extends SubmitLifeUpdateState {
  final String errorMessage;
  CorpMemberLifeUpdateStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}

/**
 *  Employed Life Update States
 * */

class EmployedLifeUpdateStateSuccess extends SubmitLifeUpdateState {

  final Map<String, dynamic> response;
  EmployedLifeUpdateStateSuccess({required this.response});

  @override
  List<Object?> get props => [response];

}

class EmployedLifeUpdateStateFailure extends SubmitLifeUpdateState {
  final String errorMessage;
  EmployedLifeUpdateStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}