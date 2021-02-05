import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Day {
  int _id;
  DateTime _date;
  List _meals;

  Day(this._id, this._date, this._meals);

  String getWeekdayName(BuildContext context) =>
      DateFormat(DateFormat.WEEKDAY, Localizations.localeOf(context).toString())
          .format(_date)
          .toString();

  getDay() => DateFormat(DateFormat.DAY).format(_date);

  getDate() => _date;
}
