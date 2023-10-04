import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:hacktoberfest_flutter/screens/splash_screen.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme.currentTheme,
            //home:HomePage(),
            home: const SplashScreen(),
            /* home: AnimatedSplash(
            imagePath: 'assets/git.png',
            home: HomePage(),
            duration: 2500,
            type: AnimatedSplashType.StaticDuration,
          ),*/

            routes: routes,
          );
        },
      ),
    );
  }
}
