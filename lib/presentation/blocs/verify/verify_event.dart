import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class VerifyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitVerificationCode extends VerifyEvent {
  final Map<String, dynamic> body;
  SubmitVerificationCode({required this.body});

  @override
  List<Object?> get props => [body];

}

class ResendVerificationCode extends VerifyEvent {
  final Map<String, dynamic> body;
  ResendVerificationCode({required this.body});

  @override
  List<Object?> get props => [body];

}

class VerifyPasswordResetCodeSent extends VerifyEvent {
  final Map<String, dynamic> body;
  VerifyPasswordResetCodeSent({required this.body});

  @override
  List<Object?> get props => [body];

}
