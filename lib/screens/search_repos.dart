import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/providers/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../shared/colors.dart';
import '../widgets/new_repo_card.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  static String routename = 'Search';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final String searchText = '';

  Future<List> listOfRepos;

  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
        //shadowColor: Colors.black26,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.palette,
                color: Provider.of<ThemeProvider>(context).isDarkTheme
                    ? Color(0xff93C2DB)
                    : Colors.grey,
              ),
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme();
              })
        ],
        title: Text(
          'Search tags',
          style: TextStyle(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          color: Theme.of(context).primaryColor,
        ),
        margin: EdgeInsets.symmetric(
          vertical: _deviceHeight * 0.04,
          horizontal: _deviceHeight * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Textfield to get the user inputs
            TextField(
              decoration: const InputDecoration(
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
              controller: _controller,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),

            //search button to call the action
            RaisedButton(
              onPressed: () async {
                if (_controller.text != null) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    setState(() {
                      listOfRepos = getRepos(_controller.text);
                    });
                  });
                } else {
                  return null;
                }
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
            //This widget display the information of the repos with the help of listview
            FutureBuilder<List<dynamic>>(
              future: listOfRepos,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  //this widget display the repos details
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return NewRepoCard(
                            listData: snapshot.data,
                            index: index,
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Expanded(
                    child: Container(
                      height: 250,
                      child: Center(
                        child: SpinKitFadingCube(
                          color: Colors.grey,
                          size: 50.0,
                        ),
                      ),
                    ),
                  );
                }

                //loading spinner
                return Expanded(
                  child: Container(
                    height: 250,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: Image(
                          alignment: Alignment.center,
                          width: _deviceWidth,
                          image: NetworkImage(
                              'https://image.freepik.com/free-vector/search-engine-concept-illustration_114360-306.jpg'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//This future func get the repos data from the Github API
//And returns the list of repos
Future<List> getRepos(String tag) async {
  final String baseURL = "https://api.github.com/search/repositories?q=" + tag;
  final response = await http
      .get(Uri.encodeFull(baseURL), headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    Map<String, dynamic> result = jsonDecode(response.body);
    List listOfRepos = result["items"];
    return listOfRepos;
  } else {
    return ["Error"];
  }
}
