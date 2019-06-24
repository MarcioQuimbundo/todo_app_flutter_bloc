import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todo_app_flutter/src/blocs/filtered_todos/filtered_todos.dart';
import "package:todo_app_flutter/src/models/models.dart";

class FilterButton extends StatelessWidget {
  final bool visible;
  FilterButton({this.visible, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.body1;
    final activeStyle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(color: Theme.of(context).accentColor);
    final FilteredTodoBloc filteredTodoBloc =
        BlocProvider.of<FilteredTodoBloc>(context);
    return BlocBuilder(
      bloc: filteredTodoBloc,
      builder: (BuildContext context, FilteredTodosState state) {
        final button = _Button(
          onSelected: (filter) {
            filteredTodoBloc.dispatch(UpdateFilter(filter));
          },
          activeFilter: state is FilteredTodosLoaded
              ? state.activeFilter
              : VisibilityFilter.all,
          activeStyle: activeStyle,
          defaultStyle: defaultStyle,
        );
        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 150),
          child: visible
              ? button
              : IgnorePointer(
                  child: button,
                ),
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeStyle,
    @required this.defaultStyle,
    @required this.activeFilter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: ArchSampleKeys.filterButton,
      tooltip: ArchSampleLocalizations.of(context).filterTodos,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) =><PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            ArchSampleLocalizations.of(context).showAll,
            style: activeFilter == VisibilityFilter.all ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.completedFilter,
          value: VisibilityFilter.completed,
          child: Text(
            ArchSampleLocalizations.of(context).showCompleted,
            style: activeFilter == VisibilityFilter.completed ? activeStyle : defaultStyle
          ),
        )
      ],
    );
  }
}