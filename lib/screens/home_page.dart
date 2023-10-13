import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'info_page.dart';
import 'contributors.dart';
import 'search_repos.dart';

class HomePage extends StatefulWidget {
  static String routename = 'HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Color(0xFF551A8B), // Hacktoberfest Purple background
        body: const TabBarView(
          children: [
            Search(),
            Contributors(),
            InfoPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.white, // Text color for selected tab
          unselectedLabelColor:
              Color(0xFFA692D0), // Light Lavender for unselected tabs
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(1.0),
          indicatorColor: Colors.orange, // Set an accent color
          tabs: const [
            Tab(
              icon: Icon(Icons.search),
              child: Text('Search'),
            ),
            Tab(
              icon: Icon(Icons.people_outline),
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
