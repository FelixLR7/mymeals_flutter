import 'package:flutter/material.dart';
import 'package:project_test/models/checkbox_list_model.dart';

class CheckboxListWidget extends StatefulWidget {
  final List list;
  final String title;
  final String error;
  final Function callback;

  CheckboxListWidget({
    Key key,
    @required this.list,
    @required this.callback,
    this.title,
    this.error,
  }) : super(key: key);

  @override
  _CheckboxListWidgetState createState() =>
      _CheckboxListWidgetState(list, title, error, callback);
}

class _CheckboxListWidgetState extends State<CheckboxListWidget> {
  CheckboxListModel _checkboxList;
  final String _title;
  final String _error;
  final Function _callback;
  bool _showError = false;
  final double defaultPadding = 10.0;

  _CheckboxListWidgetState(
    list,
    this._title,
    this._error,
    this._callback,
  ) {
    _checkboxList = new CheckboxListModel(list);
  }

  @override
  Widget build(BuildContext context) {
    final headerList = _createHeader();
    final valuesList = _valuesList();

    final checkboxList = headerList..add(valuesList);

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: checkboxList,
      ),
    );
  }

  Widget _valuesList() {
    return Flexible(
      child: ListView.builder(
        itemCount: _checkboxList.list.length,
        itemBuilder: (BuildContext context, int index) {
          return _checkboxItem(_checkboxList.list[index]);
        },
      ),
    );
  }

  Widget _checkboxItem(dynamic checkboxItem) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(checkboxItem.item.name),
      value: checkboxItem.selected,
      onChanged: (value) {
        setState(
          () {
            checkboxItem.selected = value;
            List idsSelected = _checkboxList.getIdsSelected();
            _showError = idsSelected.isEmpty;
            _callback(idsSelected);
          },
        );
      },
    );
  }

  List<Widget> _createHeader() {
    List<Widget> header = [];

    if (_title != null) {
      final finalTitle = Container(
        padding: EdgeInsets.only(left: defaultPadding),
        child: Text(
          _title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      );

      header.add(finalTitle);
    }

    if (_error != null) {
      final errorSubtitle = _errorSubtitle();

      header.add(errorSubtitle);
    }

    return header;
  }

  Widget _errorSubtitle() {
    return Visibility(
      visible: _showError,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Text(
          _error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
