//TODO: Add a functional search bar to search for tags of GITHUB repos.
//Once a search is made, it should show the repos which have that specific tag in them.

import 'package:flutter/material.dart';

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
        backgroundColor: Colors.white, 
        elevation: 5.0,
        shadowColor: Colors.black26,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: const Text('Search tags', style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: _deviceHeight * 0.04,
          horizontal: _deviceHeight * 0.04,
        ),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: const InputDecoration(
                // hintText: "Search Repository",
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(8))),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 1), width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),

                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(143, 143, 143, 1), width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                labelText: 'Search Repository',
                helperText: '* Search repos with the help of tag',
                labelStyle: const TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(48, 48, 48, 1),
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            RaisedButton(
              onPressed: () {
                // Get repos on search pressed
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [hactoberViolet, hacktoberPink],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: _deviceWidth / 3, minHeight: 40.0),
                  alignment: Alignment.center,
                  child: const Text(
                    "Search",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getRepos() {
// This function will be triggered when the user hits search on the search bar
// Depending on the the text in the TextField make an API call to the GitHub API.
// Send the tag which the user input in the search bar as an argument.
// Get the list of repos with matcching tag  and add them to a list of cards.
}
