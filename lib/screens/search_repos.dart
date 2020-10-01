//TODO: Add a functional search bar to search for tags of GITHUB repos.
//Once a search is made, it should show the repos which have that specific tag in them.

import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  static String routename = 'Search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Search tags'),
      ),
    );
  }
}


getRepos(){
// This function will be triggered when the user hits search on the search bar
// Depending on the the text in the TextField make an API call to the GitHub API.
// Send the tag which the user input in the search bar as an argument.
// Get the list of repos with matcching tag  and add them to a list of cards.  
}

