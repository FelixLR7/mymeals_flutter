import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = new Preferences._();

  factory Preferences() {
    return _instance;
  }

  Preferences._();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String token) {
    _prefs.setString('token', token);
  }

  String get name {
    return _prefs.getString('name') ?? '';
  }

  set name(String name) {
    _prefs.setString('name', name);
  }

  bool get tutorial {
    return _prefs.getBool('tutorial');
  }

  set tutorial(bool tutorial) {
    _prefs.setBool('tutorial', tutorial);
  }
}
