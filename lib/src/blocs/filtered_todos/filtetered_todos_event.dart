import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_flutter/src/models/todo_model.dart';
import 'package:todo_app_flutter/src/models/visibility_filter.dart';

@immutable
abstract class FilteredTodosEvent extends Equatable {
  FilteredTodosEvent([List props = const[]]) : super(props);
}

class UpdateFilter extends FilteredTodosEvent {
  final VisibilityFilter filter;
  UpdateFilter(this.filter) : super([filter]);

  @override
  String toString() => 'UpdateFilter {filter: $filter}';
}

class UpdateTodos extends FilteredTodosEvent {
  final List<Todo> todos;

  UpdateTodos(this.todos) : super([todos]);

  @override
  String toString() => "UpdateTodos {todos: $todos}";
}