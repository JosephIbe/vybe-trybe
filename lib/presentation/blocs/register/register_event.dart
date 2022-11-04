import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class RegisterEvent extends Equatable {

  @override
  List<Object?> get props => [];

}

class RegisterWithEmail extends RegisterEvent {

  final dynamic body;
  RegisterWithEmail({required this.body});

  @override
  List<Object> get props => [body];

}

// class VerifyUserEmail extends RegisterEvent {
//
//   final dynamic body;
//   VerifyUserEmail({required this.body});
//
//   @override
//   List<Object?> get props => [body];
//
// }