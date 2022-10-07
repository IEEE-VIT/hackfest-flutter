import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_flutter/constants/assets.dart';
import 'package:github_flutter/providers/theme_provider.dart';
import 'package:github_flutter/screens/home_page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage())));

    const color = const Color(0xff13253d);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: color),
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Image.asset(
              Assets.logo,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
