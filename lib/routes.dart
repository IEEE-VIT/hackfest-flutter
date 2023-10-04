//Routes file to store all the routes of the app
import 'package:flutter/material.dart';
import 'screens/info_page.dart';
import 'screens/contributors.dart';
import 'screens/home_page.dart';
import 'screens/search_repos.dart';
Map<String, Widget Function(BuildContext)> routes ={

 Search.routename:(ctx) => const Search(),
 HomePage.routename:(ctx) => const HomePage(),
 Contributors.routename:(ctx) => const Contributors(),
 InfoPage.routename: (ctx) => const InfoPage()

};
