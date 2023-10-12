//import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
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
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Color.fromARGB(255, 18, 16, 16),
        nextScreen: HomePage(),
        splash: 'assets/logo.png',
        splashTransition: SplashTransition.scaleTransition,
      ),
    );
  }
}
