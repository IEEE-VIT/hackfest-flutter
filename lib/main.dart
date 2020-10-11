import 'package:flutter/material.dart';

import 'routes.dart';
import 'screens/home_page.dart';
import 'shared/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: hacktoberPurple,
          primaryColor: hacktoberPurple
        ),
        home: HomePage(),
        routes: routes);
  }
}
