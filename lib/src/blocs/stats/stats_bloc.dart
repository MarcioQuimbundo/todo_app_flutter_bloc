import "dart:async";
import "package:meta/meta.dart";
import 'package:bloc/bloc.dart';
import 'package:todo_app_flutter/src/blocs/filtered_todos/filtered_todos.dart';
import 'package:todo_app_flutter/src/blocs/stats/stats_events.dart';
import 'package:todo_app_flutter/src/blocs/stats/statts_state.dart';
import 'package:todo_app_flutter/src/blocs/todos/todos.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  StatsBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.state.listen((state) {
      if (state is TodosLoaded) {
        dispatch(UpdateStats(state.todos));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive =
          event.todos.where((todo) => !todo.complete).toList().length;
      int numCompleted =
          event.todos.where((todo) => todo.complete).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  void dispose() {
    todosSubscription.cancel();
    super.dispose();
  }
}
