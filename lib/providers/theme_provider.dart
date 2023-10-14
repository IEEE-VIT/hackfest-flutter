import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeProvider({required this.isdarkTheme, this.selectedTheme});

  bool isdarkTheme;
  String? selectedTheme;

  //global lightTheme for app
  var lightTheme= ThemeData(

    fontFamily: 'Poppins-Regular',
   // backgroundColor: Color(0xfffafafa),
    iconButtonTheme : IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.black),
      ),
    ),
    secondaryHeaderColor: Colors.black,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[200],
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey[600],
    ),
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        helperStyle: TextStyle(
          color: Colors.black,
        ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Color.fromRGBO(217, 217, 217, 1),),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Color.fromRGBO(143, 143, 143, 1),),
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
   // backgroundColor: Color(0xff071724),
    iconButtonTheme : IconButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStateProperty.all(const Color(0xff93C2DB)),
        ),
    ),
    secondaryHeaderColor: const Color(0xffFDF0F0),
    primaryColor: darkModeHactober,
    scaffoldBackgroundColor: const Color(0xff0F253E),
    tabBarTheme: const TabBarTheme(
      labelColor: Color(0xff93C2DB),
      unselectedLabelColor: Colors.white60,
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
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            color: Color.fromRGBO(217, 217, 217, 1),),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.purple.shade300,),
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


  //
  bool get isDarkTheme2=> isdarkTheme;


  //changeTheme to set the theme chosen in settings page
  void changeTheme(newTheme){
    selectedTheme = newTheme;
    notifyListeners();
  }

  //setTheme , used before to change theme from light to dark and vice-versa
  void setTheme(){
    isdarkTheme = !isdarkTheme;
    notifyListeners();
  }

  //getter to get the current theme
  ThemeData get currentTheme{
    if(isdarkTheme){
      return darkTheme;
    } else {
      return lightTheme;
    }
  }
}
