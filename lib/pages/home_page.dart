import 'package:flutter/material.dart';
import 'package:project_test/models/day_model.dart';
import 'package:project_test/widgets/calendar_list_widget.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:project_test/widgets/drawer_widget.dart';
import 'package:project_test/widgets/newmealFAB_widget.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  static final pageName = 'Inicio';
  final List<Day> list = [
    Day(
      1,
      DateTime.now(),
      [1, 2, 3],
    ),
    Day(
      1,
      DateTime.now().add(Duration(days: 1)),
      [1, 2, 3],
    ),
    Day(
      1,
      DateTime.now().add(Duration(days: 2)),
      [1, 2, 3],
    )
  ];

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    initializeDateFormatting(locale.toString());

    return SafeArea(
      child: _createList(context),
    );
  }

  Widget _createList(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      drawer: MenuWidget(),
      drawerEdgeDragWidth: MenuWidget.getDragWidth(context),
      body: CalendarListWidget(list: list),
      floatingActionButton: NewMealFABWidget(),
    );
  }
}
