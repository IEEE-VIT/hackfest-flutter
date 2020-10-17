import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_flutter/screens/home_page.dart';

class SplashScreen2 extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage())));

    const color = const Color(0xffffffff);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: color),
          child: new Center(
            child: Image.asset(
              "assets/flutter.png",
            ),
          ),
        ),
      ),
    );
  }
}
