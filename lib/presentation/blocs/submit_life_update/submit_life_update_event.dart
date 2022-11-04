import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class SubmitLifeUpdateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitStudentLifeUpdate extends SubmitLifeUpdateEvent {

  final Map<String, dynamic> body;
  SubmitStudentLifeUpdate({required this.body});

  @override
  List<Object?> get props => [body];

}

class SubmitCorpMemberLifeUpdate extends SubmitLifeUpdateEvent {

  final dynamic body;
  SubmitCorpMemberLifeUpdate({required this.body});

  @override
  List<Object?> get props => [body];

}

class SubmitEmployedAndSelfEmployedLifeUpdate extends SubmitLifeUpdateEvent {

  final Map<String, dynamic> body;
  SubmitEmployedAndSelfEmployedLifeUpdate({required this.body});

  @override
  List<Object?> get props => [body];

}