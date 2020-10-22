import 'package:flutter/material.dart';
import 'package:github_flutter/providers/theme_provider.dart';
import 'package:provider/provider.dart';
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
        backgroundColor: Theme.of(context).primaryColor,
        body: TabBarView(
          children: [
            Search(), //This loads up the Search screen where the user can search for repositories on GitHub
            Contributors(), // This loads up the the Contributors card page
            InfoPage(), // TODO: Make an About Us widget
          ],
        ),
        
        bottomNavigationBar: TabBar(          
          labelColor: Provider.of<ThemeProvider>(context).isDarkTheme?
          Color(0xff93C2DB):Colors.black,
          unselectedLabelColor: Colors.grey[400],
          // indicatorSize: TabBarIndicatorSize.label,
          // indicatorPadding: EdgeInsets.all(1.0),
          // indicatorColor: Colors.red,
          tabs: [
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