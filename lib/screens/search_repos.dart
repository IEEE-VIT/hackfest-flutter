import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../shared/colors.dart';
import '../widgets/new_repo_card.dart';

class Search extends StatefulWidget {
  static String routename = 'Search';

  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _controller = TextEditingController();

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
        backgroundColor: Color(0xFF551A8B), // Change the background color
        elevation: 5.0,
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
          )
        ],
        title: Text(
          'Search tags',
          style: TextStyle(
            color: Colors.white, // Change text color
          ),
        ),
      ),
      backgroundColor: Color(0xFF551A8B),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
          color: Colors.white, // Change the background color
        ),
        margin: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.04,
          horizontal: deviceHeight * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Textfield to get the user inputs
            TextField(
              decoration: InputDecoration(
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
                primary: Colors.blue, // Change button background color
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [hactoberViolet, hacktoberPink],
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
                    "Search",
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
                          size: 50.0,
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
    return ["Error"];
  }
}
