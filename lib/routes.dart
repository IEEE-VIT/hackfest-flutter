//Routes file to store all the routes of the app
import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/screens/bookmark.dart';
import 'package:hacktoberfest_flutter/screens/contributors.dart';
import 'package:hacktoberfest_flutter/screens/home_page.dart';
import 'package:hacktoberfest_flutter/screens/info_page.dart';
import 'package:hacktoberfest_flutter/screens/profile_details.dart';
import 'package:hacktoberfest_flutter/screens/search_repos.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Search.routename: (ctx) => const Search(),
  HomePage.routename: (ctx) => const HomePage(),
  Contributors.routename: (ctx) => const Contributors(
        repoName: '',
      ),
  InfoPage.routename: (ctx) => const InfoPage(),
  ProfileDetails.routename: (ctx) => const ProfileDetails(),
  // Settings.routename: (ctx) => const Settings(),
  Bookmark.routename: (ctx) => const Bookmark(),
};
