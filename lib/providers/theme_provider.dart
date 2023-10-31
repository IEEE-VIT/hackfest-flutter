import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/main.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';

class ThemeProvider extends ChangeNotifier {
  var lightTheme = ThemeData(
    fontFamily: 'Poppins-Regular',
    focusColor: hacktoberVioletLight,
    indicatorColor: hacktoberViolet,
    highlightColor: const Color(0xFFAA96DA),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.black),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    secondaryHeaderColor: Colors.black,
    primaryColor: Colors.white,
    cardColor: lightModeButton,
    canvasColor: hacktoberViolet,
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelColor: hacktoberViolet,
      indicatorColor: hacktoberViolet,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      unselectedLabelColor: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      helperStyle: const TextStyle(
        color: Colors.black,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: hacktoberViolet,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: hacktoberViolet,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.black,
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      backgroundColor: Colors.white,
    ),
  );

  //global darkTheme for app
  var darkTheme = ThemeData(
    fontFamily: 'Poppins-Regular',
    focusColor: darkModeCardLight,
    indicatorColor: darkModeCard,
    highlightColor: const Color(0xFF206993),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(const Color(0xff93C2DB)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff3C3C3C),
    ),
    secondaryHeaderColor: const Color(0xffFDF0F0),
    primaryColor: darkMode,
    cardColor: darkModeButton,
    canvasColor: darkModeCard,
    tabBarTheme: TabBarTheme(
      labelColor: darkModeCard,
      indicatorColor: darkModeCard,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      unselectedLabelColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.white,
      labelStyle: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
      helperStyle: const TextStyle(
        color: Colors.white,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkModeCard,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkModeCard,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.lightBlueAccent,
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      backgroundColor: Color(0xff1F4172),
    ),
  );

  //changeTheme to set the theme chosen in settings page
  void changeTheme(bool isOn) {
    device.theme = isOn ? 'Dark' : 'Light';
    notifyListeners();
  }
}
