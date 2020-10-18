import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_flutter/screens/ss3.dart';

class SplashScreen1 extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen2())));

    //<- Creates a widget that displays an image.
    const color = const Color(0xff000000);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: color),
          child: new Center(
            child: Image.asset(
              "assets/download.png",
            ),
          ),
        ),
      ),
    );
  }
}
