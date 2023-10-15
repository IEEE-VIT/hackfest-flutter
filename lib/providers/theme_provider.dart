import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';

class ThemeProvider extends ChangeNotifier {
class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  var lightTheme = ThemeData(
    // backgroundColor: Color(0xfffafafa),
  var lightTheme = ThemeData(
    // backgroundColor: Color(0xfffafafa),
    secondaryHeaderColor: Colors.black,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xff0F253E),
  );
  var darkTheme = ThemeData(
      // backgroundColor: Color(0xff071724),
      secondaryHeaderColor: const Color(0xff93C2DB),
      primaryColor: darkModeHactober,
      scaffoldBackgroundColor: const Color(0Xff1F2933));
  bool get isDarkTheme => _isDarkTheme;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  get currentTheme {
    if (_isDarkTheme) {
      return darkTheme;
    } else {
      return lightTheme;
    }
  }
}
