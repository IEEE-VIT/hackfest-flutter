import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:hacktoberfest_flutter/routes.dart';
import 'package:hacktoberfest_flutter/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

//function to get the saved theme setting from cache
Future<dynamic> getSetting(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}

//Device model including theme property
class Device {
  Device({required this.theme});
  String? theme;
}

Device device = Device(theme: 'Light');

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //set the saved theme to our device

  Future<void> loadAppTheme() async {
    final String theme = await getSetting('theme');
    if(theme==null){
      setState(() {
        device.theme = 'Light';
      });
    }
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
            theme: device.theme=='Dark'? theme.darkTheme : theme.lightTheme,
            home: const SplashScreen(),
            routes: routes,
          );
        },
      ),
    );
  }
}
