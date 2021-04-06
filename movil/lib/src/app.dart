import 'package:flutter/material.dart';
import 'package:movil/src/blocs/provider.dart';
import 'package:movil/src/pages/menu_page.dart';
import 'package:movil/src/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: MenuPage(),
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) => MenuPage());
      },
    ));
  }
}
