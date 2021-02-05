import 'package:flutter/material.dart';
import 'package:project_test/providers/category_provider.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key key}) : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  void initState() {
    super.initState();
    initializeList();
    print('después init');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(),
    );
  }

  void initializeList() {
    CategoryProvider categoryProvider = new CategoryProvider();
  }
}
