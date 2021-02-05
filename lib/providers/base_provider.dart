import 'package:project_test/preferences/preferences.dart';

class BaseProvider {
  static final String url = 'http://192.168.1.59:60/api/';
  static final preferences = new Preferences();
  Map<String, String> headers;

  BaseProvider() {
    headers = {
      "Content-Type": "applications/json",
      "X-Requested-With": "XMLHttpRequest"
    };
  }
}
