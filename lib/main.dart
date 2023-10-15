import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme.currentTheme,
            home: AnimatedSplashScreen(
              splash: Image.asset('assets/git.png'),
              splashTransition: SplashTransition.fadeTransition,
              nextScreen: const HomePage(),
              duration: 2500,
            ),
            routes: routes,
          );
        },
      ),
    );
  }
}
