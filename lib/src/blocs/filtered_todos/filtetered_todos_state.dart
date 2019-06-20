import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_flutter/src/models/todo_model.dart';
import 'package:todo_app_flutter/src/models/visibility_filter.dart';

@immutable
abstract class FilteredTodosState extends Equatable {
  FilteredTodosState([List props = const []]) : super(props);
}

class FilteredTodosLoading extends FilteredTodosState {
  @override
  String toString() => "FilteredTodosLoading";
}

class FilteredTodosLoaded extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  FilteredTodosLoaded(this.filteredTodos, this.activeFilter)
      : super([filteredTodos, activeFilter]);

  @override
  String toString() =>
      "FilteredTodosLoaded { filtered: $filteredTodos, activeFilter: $activeFilter}";
}
