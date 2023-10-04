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
        backgroundColor: Theme.of(context).primaryColor,
        body: const TabBarView(
          children: [
            Search(), //This loads up the Search screen where the user can search for repositories on GitHub
            Contributors(), // This loads up the the Contributors card page
            InfoPage(), // This loads up the the Info page
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Provider.of<ThemeProvider>(context).isDarkTheme
              ? const Color(0xff93C2DB)
              : Colors.black,
          unselectedLabelColor: Colors.grey[400],
          // indicatorSize: TabBarIndicatorSize.label,
          // indicatorPadding: EdgeInsets.all(1.0),
          // indicatorColor: Colors.red,
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
