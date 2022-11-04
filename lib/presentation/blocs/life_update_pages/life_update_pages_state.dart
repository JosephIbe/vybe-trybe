import 'package:equatable/equatable.dart';

abstract class LifeUpdatePagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LifeUpdatePagesStateInitial extends LifeUpdatePagesState {}

class LifeUpdatePagesStateStudentView extends LifeUpdatePagesState {}

class LifeUpdatePagesStateCorpMemberView extends LifeUpdatePagesState {}

class LifeUpdatePagesStateEmployedView extends LifeUpdatePagesState {}

class LifeUpdatePagesStateSelfEmployedView extends LifeUpdatePagesState {}