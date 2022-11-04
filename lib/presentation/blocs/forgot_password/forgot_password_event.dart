import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendResetPasswordCode extends ForgotPasswordEvent {

  final Map<String, dynamic> body;
  SendResetPasswordCode({required this.body});

  @override
  List<Object?> get props => [body];

}

class CreateNewPassword extends ForgotPasswordEvent {

  final Map<String, dynamic> body;
  CreateNewPassword({required this.body});

  @override
  List<Object?> get props => [body];

}
