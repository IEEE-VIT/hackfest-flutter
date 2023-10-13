import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage())));

    const color = Color(0xff13253d);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: color),
          child: Center(
            child: Image.asset(
              "assets/htbf.png",
            ),
          ),
        ),
      ),
    );
  }
}
