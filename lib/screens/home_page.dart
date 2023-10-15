import 'package:flutter/material.dart';
import 'info_page.dart';
import 'contributors.dart';
import 'search_repos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routename = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Color(0xFF551A8B), // Hacktoberfest Purple background
        body: TabBarView(
          children: [
            Search(),
            Contributors(),
            InfoPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.indigo, // Text color for selected tab
          unselectedLabelColor:
              Colors.white, // Light Lavender for unselected tabs
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(1.0),
          indicatorColor: Colors.transparent, // Set an accent color
          tabs: [
            Tab(
              icon: Icon(
                Icons.search,
                color: Colors.lightBlue,
              ),
              child: Text(
                'Search',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.people_outline,
                color: Colors.lightBlue,
              ),
              child: Text(
                'Contributors',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
            Tab(
              icon: Icon(Icons.info_outline, color: Colors.lightBlue),
              child: Text(
                'About Us',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
