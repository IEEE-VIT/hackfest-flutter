import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';
import 'package:hacktoberfest_flutter/widgets/new_repo_card.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  static String routename = 'Search';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final String searchText = '';

  Future<List> listOfRepos = Future.value([]);

  TextEditingController _controller = TextEditingController();

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
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

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
                  ? const Color(0xff93C2DB)
                  : Colors.grey,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
        ],
        title: Text(
          'Search tags',
          style: TextStyle(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
          color: Theme.of(context).primaryColor,
        ),
        margin: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.04,
          horizontal: deviceHeight * 0.04,
        ),
        child: Column(
          children: <Widget>[
            //Textfield to get the user inputs
            TextField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(217, 217, 217, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(143, 143, 143, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                labelText: 'Search Repository',
                helperText: '* Search repos with the help of tag',
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(48, 48, 48, 1),
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              controller: _controller,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),

            //search button to call the action
            ElevatedButton(
              onPressed: () async {
                if (_controller.text.trim().isNotEmpty) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    listOfRepos = getRepos(_controller.text);
                  });
                } else {
                  setState(() {
                    _controller.text="";
                  });
                  return;
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.all(1.0),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [hactoberViolet, hacktoberPink],
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: deviceWidth / 3,
                    minHeight: 40.0,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Search',
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //spinner
                  return const Expanded(
                    child: SizedBox(
                      height: 250,
                      child: Center(
                        child: SpinKitFadingCube(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Expanded(
                    child: Center(
                      child: Text('Error occurred while fetching data.'),
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('No repositories found for the search term.'),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return NewRepoCard(
                        listData: snapshot.data!,
                        index: index,
                      );
                    },
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
  final String baseURL = 'https://api.github.com/search/repositories?q=$tag';
  final response = await http.get(
    Uri.parse(Uri.encodeFull(baseURL)),
    headers: {'Accept': 'application/json'},
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> result = jsonDecode(response.body);
    final List listOfRepos = result['items'];
    return listOfRepos;
  } else {
    return ['Error'];
  }
}
