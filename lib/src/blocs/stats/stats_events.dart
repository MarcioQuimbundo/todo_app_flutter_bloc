import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_flutter/src/models/todo_model.dart';
import 'package:todo_app_flutter/src/models/visibility_filter.dart';

@immutable
abstract class StatsEvent extends Equatable {
  StatsEvent([List props = const []]) : super(props);
}

class UpdateStats extends StatsEvent {
  final List<Todo> todos;

  UpdateStats(this.todos) : super([todos]);
  @override
  String toString() => "Updates { todos: $todos}";
}
