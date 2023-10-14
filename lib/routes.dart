//Routes file to store all the routes of the app
import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/screens/contributors.dart';
import 'package:hacktoberfest_flutter/screens/home_page.dart';
import 'package:hacktoberfest_flutter/screens/info_page.dart';
import 'package:hacktoberfest_flutter/screens/search_repos.dart';
import 'package:hacktoberfest_flutter/screens/settings.dart';
Map<String, Widget Function(BuildContext)> routes ={

 Search.routename:(ctx) => const Search(),
 HomePage.routename:(ctx) => const HomePage(),
 Contributors.routename:(ctx) => const Contributors(),
 InfoPage.routename: (ctx) => const InfoPage(),
 Settings.routename: (ctx) => const Settings(),

};
