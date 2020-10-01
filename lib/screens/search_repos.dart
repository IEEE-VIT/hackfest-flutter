//TODO: Add a functional search bar to search for tags of GITHUB repos.
//Once a search is made, it should show the repos which have that specific tag in them.

import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/colors.dart';

class Search extends StatelessWidget {

  static String routename = 'Search';
  String searchText;
  @override
  Widget build(BuildContext context) {

    // Used device height and width to make responsive layout
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Search tags'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: _deviceHeight * 0.04,
          horizontal: _deviceHeight * 0.04,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: "Search Repository",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
                )
              ),
            ),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            RaisedButton(
              onPressed: (){
                // Get repos on search pressed
              },
              child: Text(
                "Search",
                style: TextStyle(
                  fontSize: 12,
                  color: whiteColor
                ),
              ),
              color: githubButtonGreen,
            ),
          ],
        ),
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

