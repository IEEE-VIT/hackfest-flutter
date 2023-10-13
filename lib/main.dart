import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:hacktoberfest_flutter/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes.dart';

void main() {


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  //function to get the saved theme setting from cache
  Future<dynamic> getSetting(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  //set the saved theme to our device
  Future<void> loadAppTheme() async {
    String theme = await getSetting('theme');
    setState(() {
      device.theme = theme;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAppTheme();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    Brightness currentBrightness = MediaQuery.of(context).platformBrightness;
    // Check if the device is in dark mode
    bool isDarkTheme = currentBrightness == Brightness.dark;


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(isdarkTheme: isDarkTheme)),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: device.theme == "Dark" ? theme.darkTheme :theme.lightTheme,
            darkTheme: device.theme == "Light"? theme.lightTheme : theme.darkTheme ,
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
