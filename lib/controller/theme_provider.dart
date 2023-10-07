import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class ThemeProvider extends ChangeNotifier{

  bool _isDarkTheme = false;

  var lightTheme= ThemeData(
   // backgroundColor: Color(0xfffafafa),
    secondaryHeaderColor: Colors.black,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[100],
  );
  var darkTheme = ThemeData(
   // backgroundColor: Color(0xff071724),
    secondaryHeaderColor: const Color(0xff93C2DB),
    primaryColor: darkModeHactober,
    scaffoldBackgroundColor: const Color(0xff0F253E),
  );
 bool get isDarkTheme=> _isDarkTheme;

  void changeTheme(){
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  get currentTheme{
    if(_isDarkTheme){
      return darkTheme;
    }else {
      return lightTheme;
    }
  }


}