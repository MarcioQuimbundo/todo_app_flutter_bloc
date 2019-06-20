import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_flutter/src/blocs/filtered_todos/filtetered_todos_event.dart';
import 'package:todo_app_flutter/src/blocs/filtered_todos/filtetered_todos_state.dart';
import 'package:todo_app_flutter/src/blocs/todos/todos_bloc.dart';
import 'package:todo_app_flutter/src/blocs/todos/todos_state.dart';
import 'package:todo_app_flutter/src/models/todo_model.dart';
import 'package:todo_app_flutter/src/models/visibility_filter.dart';

class FilteredTodoBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubsciption;

  FilteredTodoBloc({@required this.todosBloc}) {
    todosSubsciption = todosBloc.state.listen((state) {
      if (state is TodosLoaded) {
        dispatch(UpdateTodos((todosBloc.currentState as TodosLoaded).todos));
      }
    });
  }

  @override
  FilteredTodosState get initialState {
    return todosBloc.currentState is TodosLoaded
        ? FilteredTodosLoaded(
            (todosBloc.currentState as TodosLoaded).todos, VisibilityFilter.all)
        : FilteredTodosLoading();
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateTodos) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(
      UpdateFilter event) async* {
    if (todosBloc.currentState is TodosLoaded) {
      yield FilteredTodosLoaded(
          _mapTodosToFilteredTodos(
              (todosBloc.currentState as TodosLoaded).todos, event.filter),
          event.filter);
    }
  }

  List _mapTodosToFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else if (filter == VisibilityFilter.completed) {
        return todo.complete;
      }
    }).toList();
  }

  Stream<FilteredTodosState> _mapTodosUpdatedToState(UpdateTodos event) async* {
    final visibilityFilter = currentState is FilteredTodosLoaded
        ? (currentState as FilteredTodosLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
            (todosBloc.currentState as TodosLoaded).todos, visibilityFilter),
        visibilityFilter);
  }
  
  @override 
  void dispose() {
    todosSubsciption.cancel();
    super.dispose();
  }
}
