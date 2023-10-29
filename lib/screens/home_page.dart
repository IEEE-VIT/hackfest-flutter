import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:hacktoberfest_flutter/screens/bookmark.dart';
import 'package:hacktoberfest_flutter/screens/info_page.dart';
import 'package:hacktoberfest_flutter/screens/search_repos.dart';
import 'package:hacktoberfest_flutter/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:hacktoberfest_flutter/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routename = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
  final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 5.0,
          title: const Text('HackFest', style: TextStyle(color: Colors.black),),
          //shadowColor: Colors.black26,
          iconTheme: IconThemeData(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        endDrawer: const ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35),),
            child: DrawerWidget(),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: const TabBarView(
          children: [
            Search(), //This loads up the Search screen where the user can search for repositories on GitHub
            Bookmark(),
            InfoPage(), // This loads up the the Info page
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Theme.of(context).tabBarTheme.labelColor,
          unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
          labelStyle: Theme.of(context).tabBarTheme.labelStyle,
          unselectedLabelStyle: themeProvider.lightTheme.tabBarTheme.unselectedLabelStyle,
          tabs: const [
            Tab(
              icon: Icon(Icons.search,size: 25,),
              child: Text('Search',),
            ),
            Tab(
              icon: Icon(Icons.bookmark_border,size: 25,),
              child: Text('Bookmarks'),
            ),
            Tab(
              icon: Icon(Icons.info_outline,size: 25,),
              child: Text('About Us'),
            ),
          ],
          indicatorWeight: 4,
          indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
        ),
      ),
    );
  }
}
