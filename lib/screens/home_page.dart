import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/screens/contributors.dart';
import 'package:hacktoberfest_flutter/screens/info_page.dart';
import 'package:hacktoberfest_flutter/screens/search_repos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routename = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: const TabBarView(
          children: [
            Search(), //This loads up the Search screen where the user can search for repositories on GitHub
            InfoPage(), // This loads up the the Info page
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.search),
              child: Text('Search'),
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
