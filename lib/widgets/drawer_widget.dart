import 'package:flutter/material.dart';

import 'package:project_test/pages/home_page.dart';
import 'package:project_test/pages/meals_page.dart';
import 'package:project_test/providers/user_provider.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/menu-img.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: Text(HomePage.pageName),
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.blue),
            title: Text(MealsPage.pageName),
            onTap: () {
              Navigator.pushReplacementNamed(context, MealsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Ajustes'),
            onTap: () {},
          ),
          ListTile(
              leading: Icon(Icons.logout, color: Colors.blue),
              title: Text('Salir'),
              onTap: () async {
                UserProvider userProvider = UserProvider();
                // TODO: quitar await y mostrar snackbar en la siguiente página
                // TODO: gestionar si no hay conexión a internet
                await userProvider.logout();
                Navigator.pushReplacementNamed(context, 'login');
              }),
        ],
      ),
    );
  }

  static double getDragWidth(context) {
    return MediaQuery.of(context).size.width / 2;
  }
}
