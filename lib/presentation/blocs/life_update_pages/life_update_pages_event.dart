import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

abstract class LifeUpdatePagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDefaultLifeUpdatePage extends LifeUpdatePagesEvent {}

class LoadStudentLifeUpdatePage extends LifeUpdatePagesEvent {}

class LoadCorpMemberLifeUpdatePage extends LifeUpdatePagesEvent {}

class LoadEmployedLifeUpdatePage extends LifeUpdatePagesEvent {}

class LoadSelfEmployedLifeUpdatePage extends LifeUpdatePagesEvent {}