import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/screens/bookmark.dart';
import 'package:hacktoberfest_flutter/screens/info_page.dart';
import 'package:hacktoberfest_flutter/screens/search_repos.dart';

import '../widgets/drawer.dart';

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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 5.0,
          title: Text('HackFest', style: TextStyle(color: Colors.black),),
          //shadowColor: Colors.black26,
          iconTheme: IconThemeData(
            color: Theme.of(context).secondaryHeaderColor,
          )
        ),
        endDrawer: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35)),
            child: DrawerWidget()
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: const TabBarView(
          children: [
            Search(), //This loads up the Search screen where the user can search for repositories on GitHub
            Bookmark(),
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
              icon: Icon(Icons.bookmark_border),
              child: Text('Bookmarks'),
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
