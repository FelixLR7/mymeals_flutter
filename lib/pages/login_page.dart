import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_test/pages/home_page.dart';
import 'package:project_test/pages/tutorial_page.dart';
import 'package:project_test/preferences/preferences.dart';

import 'package:project_test/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  static final routeName = 'login';
  static final pageName = 'Login';

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '272743427264-gfa6339419gc2362bceddpmivi8go91u.apps.googleusercontent.com',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Google Sign In'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login' + name,
              style: TextStyle(fontSize: 30.0),
            ),
            Divider(),
            RaisedButton(
              child: Text('Sign in'),
              onPressed: () => _signIn(context),
            )
          ],
        ),
      ),
    );
  }

  void _signIn(BuildContext context) async {
    await _googleSignIn.signOut();

    GoogleSignInAccount user = await _googleSignIn.signIn();
    print('User flutter: ');
    print(user);
    GoogleSignInAuthentication userAuth = await user.authentication;

    if (userAuth == null) {
      final snackbar =
          _snackbar('Ha habido un fallo con el inicio de sesión de Google');

      scaffoldKey.currentState.showSnackBar(snackbar);
    } else {
      UserProvider userProvider = new UserProvider();
      // userProvider.createUser(user.email, user.displayName, userAuth.accessToken);

      bool successSignUp = await userProvider.createUser(
          'felix4@gmail.com', 'Félix', userAuth.accessToken);

      if (successSignUp) {
        Preferences prefs = new Preferences();

        if (prefs.tutorial) {
          Navigator.pushReplacementNamed(context, TutorialPage.routeName);
        } else {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } else {
        final snackbar = _snackbar('Ha habido un problema al crear la cuenta');

        scaffoldKey.currentState.showSnackBar(snackbar);
      }
    }
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
