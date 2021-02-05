import 'package:flutter/material.dart';
import 'package:project_test/pages/example_meals_page.dart';
import 'package:project_test/pages/home_page.dart';
import 'package:project_test/pages/login_page.dart';
import 'package:project_test/pages/meal_page.dart';
import 'package:project_test/pages/meals_page.dart';
import 'package:project_test/pages/splash_page.dart';
import 'package:project_test/pages/tutorial_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    SplashPage.routeName: (BuildContext context) => SplashPage(),
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    TutorialPage.routeName: (BuildContext context) => TutorialPage(),
    HomePage.routeName: (BuildContext context) => HomePage(),
    MealsPage.routeName: (BuildContext context) => MealsPage(),
    MealPage.routeName: (BuildContext context) => MealPage(),
    ExampleMealsPage.routeName: (BuildContext context) => ExampleMealsPage(),
  };
}
