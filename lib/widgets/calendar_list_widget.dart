import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_test/models/day_model.dart';
import 'package:project_test/utils/string_utils.dart';

class CalendarListWidget extends StatelessWidget {
  final List<Day> list;
  static const double _padding = 8.0;

  const CalendarListWidget({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        itemCount: list.length,
        itemBuilder: _createTile,
      ),
    );
  }

  Widget _createTile(BuildContext context, int index) {
    return Container(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        elevation: 5.0,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _day(context, index),
              _schedulesList(index),
              _mealsList(index),
            ],
          ),
        ),
      ),
    );
  }

  _day(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            list[index].getDay(),
            style: const TextStyle(fontSize: 30.0),
          ),
          Text(
            list[index].getWeekdayName(context).inCaps,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  _schedulesList(index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: _padding),
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Desayuno'),
          const Divider(),
          Text('Comida'),
          const Divider(),
          Text('Merienda'),
          const Divider(),
          Text('Cena'),
        ],
      ),
    );
  }

  _mealsList(index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, _padding, 0.0, _padding),
      child: Column(
        // TODO: controlar overflow de las posibles comidas
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Macarrones con tomatito'),
          Divider(),
          Text('Paella'),
          Divider(),
          Text('Arroz a la cubana'),
          Divider(),
          Text('Ensalada de pasta'),
        ],
      ),
    );
  }
}
