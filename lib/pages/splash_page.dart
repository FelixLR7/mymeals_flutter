import 'package:flutter/material.dart';
import 'package:project_test/pages/home_page.dart';
import 'package:project_test/pages/login_page.dart';
import 'package:project_test/preferences/preferences.dart';

class SplashPage extends StatefulWidget {
  static final routeName = 'splashscreen';

  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String name = '';

  @override
  void initState() {
    super.initState();

    // When build is finished or will break "Navigator.push..."
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserSignedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido' + name,
              style: TextStyle(fontSize: 30.0),
            ),
            Divider(),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void _checkUserSignedIn() async {
    Preferences prefs = new Preferences();

    if (prefs.token.isEmpty) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }
}
