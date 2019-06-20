import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_flutter/src/models/app_tab.dart';
import 'package:todo_app_flutter/src/models/todo_model.dart';

@immutable
abstract class TabEvent extends Equatable {
  TabEvent([List props = const []]):super([props]);
}

class UpdateTab extends TabEvent {
  final AppTab tab;
  UpdateTab(this.tab) : super([tab]);

  @override
  String toString() => 'UpdatedTab { tab: $tab}';
}