import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginEvent extends Equatable {

  @override
  List<Object?> get props => [];

}

class LoginWithEmail extends LoginEvent {

  final dynamic body;
  LoginWithEmail({required this.body});

  @override
  List<Object> get props => [body];

}