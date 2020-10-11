//Routes file to store all the routes of the app
import 'package:flutter/material.dart';
// import 'package:github_flutter/screens/new_contributor_info.dart';
import 'screens/contributors.dart';
import 'screens/info_page.dart';
import 'screens/home_page.dart';
import 'screens/search_repos.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Search.routename: (ctx) => Search(),
  HomePage.routename: (ctx) => HomePage(),
  Contributors.routename: (ctx) => Contributors(),
  AboutUs.routename: (ctx) => AboutUs(),
  // ContributorInformation.routename: (ctx) => ContributorInformation()
};
