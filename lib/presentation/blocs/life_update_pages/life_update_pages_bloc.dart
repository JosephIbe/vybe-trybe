import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_state.dart';

class LifeUpdatePagesBloc
    extends Bloc<LifeUpdatePagesEvent, LifeUpdatePagesState> {

  LifeUpdatePagesBloc(LifeUpdatePagesState initialState) : super(LifeUpdatePagesStateInitial());

  @override
  Stream<LifeUpdatePagesState> mapEventToState(
      LifeUpdatePagesEvent event) async* {
    if(event is LoadDefaultLifeUpdatePage) {
      yield* _mapLoadDefaultLifeUpdatePageToState(event);
    }

    if(event is LoadStudentLifeUpdatePage) {
      yield* _mapLoadStudentLifeUpdatePageToState(event);
    }

    if(event is LoadCorpMemberLifeUpdatePage) {
      yield* _mapLoadCorpMemberLifeUpdatePageToState(event);
    }

    if(event is LoadEmployedLifeUpdatePage) {
      yield* _mapLoadEmployedLifeUpdatePageToState(event);
    }

    if(event is LoadSelfEmployedLifeUpdatePage) {
      yield* _mapLoadSelfEmployedLifeUpdatePageToState(event);
    }
  }

  Stream<LifeUpdatePagesState> _mapLoadDefaultLifeUpdatePageToState (LoadDefaultLifeUpdatePage event) async* {
    yield LifeUpdatePagesStateInitial();
  }

  Stream<LifeUpdatePagesState> _mapLoadStudentLifeUpdatePageToState (LoadStudentLifeUpdatePage event) async* {
    yield LifeUpdatePagesStateStudentView();
  }

  Stream<LifeUpdatePagesState> _mapLoadCorpMemberLifeUpdatePageToState (LoadCorpMemberLifeUpdatePage event) async* {
    yield LifeUpdatePagesStateCorpMemberView();
  }

  Stream<LifeUpdatePagesState> _mapLoadEmployedLifeUpdatePageToState (LoadEmployedLifeUpdatePage event) async* {
    yield LifeUpdatePagesStateEmployedView();
  }

  Stream<LifeUpdatePagesState> _mapLoadSelfEmployedLifeUpdatePageToState (LoadSelfEmployedLifeUpdatePage event) async* {
    yield LifeUpdatePagesStateSelfEmployedView();
  }
}
