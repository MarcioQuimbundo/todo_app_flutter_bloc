import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/src/blocs/tab/tab_event.dart';
import 'package:todo_app_flutter/src/blocs/tab/tab_state.dart';
import 'package:todo_app_flutter/src/models/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}