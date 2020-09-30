//Routes file to store all the routes of the app
import 'package:flutter/material.dart';
import 'screens/info_page.dart';
import 'screens/contributors.dart';
import 'screens/home_page.dart';
import 'screens/search_repos.dart';
Map<String, Widget Function(BuildContext)> routes ={

 Search.routename:(ctx) => Search(),
 HomePage.routename:(ctx) => HomePage(),
 Contributors.routename:(ctx) => Contributors(),
 InfoPage.routename: (ctx) => InfoPage()

};
