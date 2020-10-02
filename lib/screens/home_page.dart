/*
  This file  contains the Navigation bar which helps the user navigate through the various pages of app
*/

import 'package:flutter/material.dart';
import 'info_page.dart';
import 'contributors.dart';
import 'search_repos.dart';


class HomePage extends StatefulWidget {
  static String routename = 'HomePage';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            Search(), //This loads up the Search screen where the user can search for repositories on GitHub
            Contributors(), // This loads up the the Contributors card page
            InfoPage(), // TODO: Make an About Us widget
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.amber[800],
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.red,
          tabs: [
            Tab(
              icon: Icon(Icons.search),
              child: Text('Search'),
            ),
            Tab(
              icon: Icon(Icons.rss_feed),
              child: Text('Contributors'),
            ),
            Tab(
              icon: Icon(Icons.info_outline),
              child: Text('About Us'),
            ),
          ],
        ),
      ),
    );
  }
}