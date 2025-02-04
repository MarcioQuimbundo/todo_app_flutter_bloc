import "package:flutter/material.dart";
import 'package:todo_app_flutter/src/ui/widgets/extra_actions.dart';
import 'package:todo_app_flutter/src/ui/widgets/filter_button.dart';
import 'package:todo_app_flutter/src/ui/widgets/filtered_todos.dart';
import 'package:todo_app_flutter/src/ui/widgets/stats.dart';
import 'package:todo_app_flutter/src/ui/widgets/tab_selector.dart';
import "package:todos_app_core/todos_app_core.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_app_flutter/src/blocs/blocs.dart";
import "package:todo_app_flutter/localization.dart";
import "package:todo_app_flutter/src/models/models.dart";

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);
    return BlocBuilder(
      bloc: tabBloc,
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
            actions: <Widget>[
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTodo,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => tabBloc.dispatch(UpdateTab(tab))
          ),
        );
      },
    );
  }
}
