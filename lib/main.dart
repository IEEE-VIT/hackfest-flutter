import 'package:flutter/material.dart';
import 'package:github_flutter/screens/splash_screen.dart';

import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home:HomePage(),
      home: SplashScreen(),
      /* home: AnimatedSplash(
        imagePath: 'assets/git.png',
        home: HomePage(),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),*/

      routes: routes,
    );
  }
}
