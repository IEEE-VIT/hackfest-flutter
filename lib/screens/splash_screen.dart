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
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8),
          color: const Color.fromARGB(246, 8, 4, 17),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                child: Image.asset('assets/htbf2.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
