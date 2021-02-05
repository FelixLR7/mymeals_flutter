import 'package:flutter/material.dart';
import 'package:project_test/models/category_model.dart';
import 'package:project_test/models/weekday_model.dart';
import 'package:project_test/pages/meals_page.dart';
import 'package:project_test/providers/category_provider.dart';
import 'package:project_test/providers/meal_provider.dart';
import 'package:project_test/widgets/checkbox_list_widget.dart';

class TutorialPage extends StatefulWidget {
  static final routeName = 'tutorial';

  TutorialPage({Key key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  bool _scrollEnabled = true;
  bool _showArrow = false;
  List<CategoryModel> _categories;
  List<WeekdayModel> _weekdays;
  List<int> _selectedMeals;
  List<int> _selectedCategories;
  List<int> _selectedWeekdays;

  PageController _pageController = PageController();
  GlobalKey pageViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initializeLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          key: pageViewKey,
          physics: _scrollEnabled
              ? PageScrollPhysics()
              : NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            _page(_firstPage),
            _page(_secondPage),
            _page(_thirdPage),
            _page(_fourthPage),
            _page(_fifthPage),
            _page(_sixthPage),
          ],
        ),
      ),
    );
  }

  Widget _page(Function content) {
    return Row(
      children: [
        Flexible(
          child: content(),
        ),
        Visibility(
          visible: _showArrow,
          child: _rightArrow(),
        )
      ],
    );
  }

  Widget _rightArrow() {
    return Container(
      child: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.blue,
          size: 40.0,
        ),
        onPressed: _nextPageButton,
      ),
    );
  }

  void _nextPageButton() {
    _pageController.nextPage(
      duration: Duration(
        seconds: 1,
      ),
      curve: Curves.easeOutCubic,
    );
  }

  Widget _firstPage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _title('La nueva forma de organizar tus comidas'),
          Text(
            'Deja de pensar qué comes mañana y sólo mira tu planning semanal. Ahorra al tener todas tus comidas planificadas',
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () => setState(() {
              _scrollEnabled = _showArrow = true;
            }),
            child: Text(
              'Antes de usar la aplicación, sería mejor que leyeras algunos consejos para que te sea más fácil su uso. Si has leído esto, pulsa aquí para desbloquear el botón y seguir',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _secondPage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _title('El resultado depende de ti'),
          Text(
            'Cuantas más comidas introduzcas y más variedad de éstas tengas, más variado será el calendario final',
            textAlign: TextAlign.center,
          ),
          Text(
            'El calendario mostrará hasta el domingo de la semana siguiente. La siguiente semana se generará el domingo de la primera semana, para que así puedas anticiparte y tener un mayor control',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _thirdPage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _title('Características'),
              _listItem(
                  'Seleccionar los días que quieres que se genere el calendario'),
              _listItem(
                  'Seleccionar qué horarios quieres que se generen (desayuno, almuerzo, comida, merienda o cena)'),
              _listItem(
                  'Elegir las categorías entre las que podrás elegir al introducir una nueva comida'),
            ],
          ),
        ],
      ),
    );
  }

  final _weekdays2 = [
    WeekdayModel(1, 'Lunes'),
    WeekdayModel(2, 'Martes'),
    WeekdayModel(3, 'Miércoles'),
    WeekdayModel(4, 'Jueves'),
    WeekdayModel(5, 'Viernes'),
    WeekdayModel(6, 'Sábado'),
    WeekdayModel(7, 'Domingo'),
  ];

  Widget _fourthPage() {
    List<Widget> widgetList = [
      CheckboxListWidget(
        list: _weekdays2,
        title: 'Días de la semana',
        error: 'Tienes que seleccionar al menos un día',
        callback: setSelectedMeals,
      ),
    ];

    return _contentWithCheckboxList(widgetList);
  }

  Widget _fifthPage() {
    CategoryProvider categoryProvider = CategoryProvider();
    List<Widget> widgetList = [
      FutureBuilder(
        future: categoryProvider.loadAllCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CheckboxListWidget(
              list: snapshot.data,
              title: 'Elige tus categorías ',
              error: 'Tienes que seleccionar al menos una categoría',
              callback: setSelectedCategories,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    ];

    return _contentWithCheckboxList(widgetList);
  }

  Widget _sixthPage() {
    MealProvider mealProvider = new MealProvider();

    List<Widget> widgetList = [
      FutureBuilder(
        future: mealProvider.loadExampleMeals(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CheckboxListWidget(
              list: snapshot.data,
              title: 'Comidas de ejemplo',
              // TODO: configurar si el error es falso (la lista no necesita un mínimo)
              error: 'Tienes que seleccionar al menos una categoría',
              callback: setSelectedMeals,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      Container(
        color: Colors.blue,
        width: double.infinity,
        child: FlatButton(
          child: Text('Empezar'),
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            MealsPage.routeName,
          ),
        ),
      ),
    ];
    return _contentWithCheckboxList(widgetList);
  }

  Widget _contentWithCheckboxList(List<Widget> widgetList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgetList,
      ),
    );
  }

  void setSelectedCategories(List<int> listSeletectedCategories) {
    _selectedCategories = listSeletectedCategories;
    // _nextPageButton();
  }

  void setSelectedMeals(List<int> listSelectedtedMeals) {
    _selectedMeals = listSelectedtedMeals;
  }

  void setSelectedWeekdays(List<int> listSeletectedWeekdays) {
    _selectedWeekdays = listSeletectedWeekdays;
  }

  Widget _title(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
    );
  }

  Widget _listItem(String sentence) {
    return Row(
      children: [
        Container(
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text('\u2022')],
          ),
        ),
        Flexible(
          child: Text(
            sentence,
          ),
        ),
      ],
    );
  }

  void initializeLists() async {
    CategoryProvider categoryProvider = CategoryProvider();
    _categories = await categoryProvider.loadAllCategories();

    // _pageController.addListener(() {
    //   if (_pageController.page == 3) {
    //     setState(() {
    //       _scrollEnabled = false;
    //     });
    //   }

    //   if (_pageController.page >= 3.9) {
    //     setState(() {
    //       _showArrow = false;
    //     });
    //   }
    // });
  }
}
