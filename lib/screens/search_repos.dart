//TODO: Add a functional search bar to search for tags of GITHUB repos.
//Once a search is made, it should show the repos which have that specific tag in them.

import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  static String routename = 'Search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Search tags'),
      ),
    );
  }
}
