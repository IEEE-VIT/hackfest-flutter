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

  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<dynamic>> listOfRepos = Future.value([]);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 5.0,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.palette,
              color: Provider.of<ThemeProvider>(context).isDarkTheme
                  ? Colors.purple
                  : Colors.grey,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          )
        ],
        title: const Text(
          'Search tags',
          style: TextStyle(
            color: Colors.white, // Change text color
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          color: Colors.white, // Change the background color
        ),
        margin: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.04,
          horizontal: deviceHeight * 0.04,
        ),
        child: Column(
          children: <Widget>[
            // Textfield to get the user inputs
            TextField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey, // Change border color
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Change focused border color
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                labelText: 'Search Repository',
                helperText: '* Search repos with the help of tag',
                labelStyle: TextStyle(
                  fontSize: 18, // Increase font size
                  color: Colors.black, // Change label text color
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

            // Search button to call the action
            ElevatedButton(
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    listOfRepos = getRepos(_controller.text);
                  });
                } else {
                  return;
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.all(1.0),
                  backgroundColor: Colors.deepPurple,
                  elevation: 0 // Change button background color
                  ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
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
            // This widget displays the information of the repos with the help of listview
            FutureBuilder<List<dynamic>>(
              future: listOfRepos,
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  // This widget displays the repos details
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return NewRepoCard(
                          listData: snapshot.data!,
                          index: index,
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
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
                }

                // Loading spinner
                return SizedBox(
                  height: 250,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: Image(
                        alignment: Alignment.center,
                        width: deviceWidth,
                        image: const NetworkImage(
                          'https://image.freepik.com/free-vector/search-engine-concept-illustration_114360-306.jpg',
                        ),
                        errorBuilder: (context, error, stackTrace) {
                          print('Image loading error: $error');
                          return const Text('Image not available');
                        },
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

// This future func gets the repos data from the Github API
// And returns the list of repos
Future<List<dynamic>> getRepos(String tag) async {
  final String baseURL =
      "https://api.github.com/search/repositories?q=topic:$tag&per_page=100";
  final response = await http.get(
    Uri.parse(Uri.encodeFull(baseURL)),
    headers: {"Accept": "application/json"},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> result = json.decode(response.body);
    List<dynamic> listOfRepos = result["items"];
    return listOfRepos;
  } else {
    return ['Error'];
  }
}
