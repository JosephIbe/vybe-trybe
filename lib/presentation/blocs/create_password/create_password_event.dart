import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class CreatePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitNewPassword extends CreatePasswordEvent {
  final dynamic body;
  SubmitNewPassword({required this.body});

  @override
  List<Object?> get props => [body];

}
