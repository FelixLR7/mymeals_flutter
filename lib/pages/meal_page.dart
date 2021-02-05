import 'package:flutter/material.dart';
import 'package:project_test/bloc/meals_bloc.dart';
import 'package:project_test/models/category_model.dart';
import 'package:project_test/models/checkbox_list_model.dart';
import 'package:project_test/models/meal_model.dart';
import 'package:project_test/models/schedule_model.dart';
import 'package:project_test/models/weekday_model.dart';
import 'package:project_test/pages/meals_page.dart';
import 'package:project_test/providers/meal_provider.dart';
import 'package:project_test/widgets/checkbox_list_widget.dart';

class MealPage extends StatefulWidget {
  static final routeName = 'meal';
  static final pageName = 'Nueva comida';

  MealPage({Key key}) : super(key: key);

  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final textFormFieldKey = GlobalKey<FormFieldState>();

  MealModel meal = new MealModel();

  Map<String, bool> errors = {
    'category': false,
    'weekday': false,
    'schedule': false,
  };

  final double defaultPadding = 10.0;

  List selectedWeekdays = [];

  ScrollController scrollController = ScrollController();

  final List _categories = [
    CategoryModel(0, 'Pescado'),
    CategoryModel(2, 'Carne'),
    CategoryModel(3, 'Pasta'),
    CategoryModel(4, 'Legumbres'),
  ];

  final _schedules = [
    ScheduleModel(1, 'Desayuno'),
    ScheduleModel(2, 'Almuerzo'),
    ScheduleModel(3, 'Comida'),
    ScheduleModel(4, 'Merienda'),
    ScheduleModel(5, 'Cena'),
  ];

  final _weekdays = [
    WeekdayModel(1, 'Lunes'),
    WeekdayModel(2, 'Martes'),
    WeekdayModel(3, 'Miércoles'),
    WeekdayModel(4, 'Jueves'),
    WeekdayModel(5, 'Viernes'),
    WeekdayModel(6, 'Sábado'),
    WeekdayModel(7, 'Domingo'),
  ];

  final _weekdaysList2 = CheckboxListModel([
    CheckboxListItemModel(WeekdayModel(1, 'Lunes')),
    CheckboxListItemModel(WeekdayModel(3, 'Miércoles')),
    CheckboxListItemModel(WeekdayModel(2, 'Martes')),
    CheckboxListItemModel(WeekdayModel(4, 'Jueves')),
    CheckboxListItemModel(WeekdayModel(5, 'Viernes')),
    CheckboxListItemModel(WeekdayModel(6, 'Sábado')),
    CheckboxListItemModel(WeekdayModel(7, 'Domingo')),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(MealPage.pageName),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: _createForm(),
      ),
    );
  }

  _createForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _createNameField(),
          _categoryList(),
          _schedulesList(),
          _weekdaysList(),
          _saveButton(),
        ],
      ),
    );
  }

  _createNameField() {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: TextFormField(
        key: textFormFieldKey,
        initialValue: meal.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Nombre',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _validateName,
        onSaved: (value) => meal.name = value,
      ),
    );
  }

  Widget _categoryList() {
    final headerList = _createHeader('Categoría',
        'Tienes que seleccionar al menos una categoría', 'category');

    final valuesList =
        _categories.map<Widget>((item) => _radiobuttonItem(item)).toList();

    final list = headerList..addAll(valuesList);

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  Widget _weekdaysList() {
    final headerList = _createHeader('Días de la semana',
        'Tienes que seleccionar al menos un día', 'weekday');
    final valuesList = _createCheckboxList(
      _weekdays,
      _anyWeekdaySelected,
      'weekday',
    );

    final list = headerList..addAll(valuesList);

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  Widget _schedulesList() {
    final headerList = _createHeader(
      'Horario',
      'Tienes que seleccionar al menos un horario',
      'schedule',
    );
    final valuesList = _createCheckboxList(
      _schedules,
      _anyScheduleSelected,
      'schedule',
    );

    final list = headerList..addAll(valuesList);

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  List<Widget> _createHeader(String title, String error, String keyError) {
    List<Widget> header = [];

    final finalTitle = Container(
      padding: EdgeInsets.only(left: defaultPadding),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );

    final errorSubtitle = _errorSubtitle(error, keyError);

    header.add(finalTitle);
    header.add(errorSubtitle);
    header.add(const Divider());

    return header;
  }

  Widget _errorSubtitle(String error, String keyError) {
    return Visibility(
      visible: errors[keyError],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  List<Widget> _createCheckboxList(
      List list, Function checkListFunction, String errorKey) {
    return list
        .map<Widget>((item) => _checkboxItem(item, checkListFunction, errorKey))
        .toList();
  }

  Widget _checkboxItem(
    dynamic item,
    Function anyValueSelected,
    String errorKey,
  ) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(item.name),
      value: item.selected,
      onChanged: (value) {
        setState(() {
          item.selected = value;
          errors[errorKey] = !anyValueSelected();
        });
      },
    );
  }

  Widget _radiobuttonItem(CategoryModel category) {
    return RadioListTile(
      title: Text(category.name),
      value: category,
      groupValue: meal.category,
      onChanged: (value) {
        setState(() {
          meal.category = value;
          errors['category'] = false;
        });
      },
    );
  }

  Widget _saveButton() {
    return RaisedButton(
      child: Text('Guardar'),
      onPressed: _submit,
    );
  }

  bool _anyWeekdaySelected() {
    return _weekdays.any((element) => true);
  }

  bool _anyScheduleSelected() {
    return _schedules.any((element) => true);
  }

  List<dynamic> _getCheckboxListSelected(List<dynamic> list) {
    return list.where((element) => element.selected).toList();
  }

  bool _isFormValid() {
    if (meal.category == null) {
      errors['category'] = true;
    }

    if (!_anyWeekdaySelected()) {
      errors['weekday'] = true;
    }

    if (!_anyScheduleSelected()) {
      errors['schedule'] = true;
    }

    if (!formKey.currentState.validate() || errors.containsValue(true)) {
      setState(() {});

      scrollController.animateTo(
        0,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );

      return false;
    }

    return true;
  }

  void _submit() async {
    if (!_isFormValid()) return;

    formKey.currentState.save();
    meal.weekdays = _getCheckboxListSelected(_weekdays);
    meal.schedules = _getCheckboxListSelected(_schedules);

    MealsBloc mealsBloc = new MealsBloc();

    if (await mealsBloc.addMeal(meal)) {
      Navigator.pushReplacementNamed(context, MealsPage.routeName);
    } else {
      final snackbar = _snackbar(
          'Ha habido un problema al crear la comida, inténtalo de nuevo');

      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  String _validateName(String name) {
    if (name.length > 0) {
      return null;
    }

    return 'Debes introducir un nombre';
  }

  Widget _snackbar(String text) {
    return SnackBar(
      content: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.error),
          ),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'Ayuda',
        // TODO: implementar ayuda si hay fallo de inicio de sesión
        onPressed: () {},
      ),
    );
  }
}
