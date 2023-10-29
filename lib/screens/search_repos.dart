import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hacktoberfest_flutter/screens/settings.dart';
import 'package:hacktoberfest_flutter/widgets/custom_button.dart';
import 'package:hacktoberfest_flutter/widgets/new_repo_card.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});
  static String routename = 'Search';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

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

    final Brightness currentBrightness =
        MediaQuery.of(context).platformBrightness;
    // Check if the device is in dark mode
    final bool isDarkMode = currentBrightness == Brightness.dark;

    Color inputColor = Colors.black;

    // Check the theme conditions and set the inputText of the search field accordingly
    if (device.theme == 'Dark') {
      inputColor = Colors.white;
    } else if (device.theme == 'Light') {
      inputColor = Colors.black;
    } else if (isDarkMode == true && device.theme == 'System Default') {
      inputColor = Colors.white;
    } else if (isDarkMode == false && device.theme == 'System Default') {
      inputColor = Colors.black;
    }

    Future<void> serachRepos() async {
      if (_controller.text.trim().isNotEmpty) {
        FocusScope.of(context).unfocus();
        setState(() {
          listOfRepos = getRepos(_controller.text);
        });
      } else {
        setState(() {
          _controller.clear();
        });
        return;
      }
    }
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(deviceWidth * 0.05),
        child: Column(
          children: <Widget>[
            //Text field to get the user inputs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: deviceWidth*0.63,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color,width: 2,),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color,width: 2,),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Search Repository',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    controller: _controller,
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(
                          '[ 0-9a-zA-Z._-]',
                        ),
                      ),
                    ],
                  ),
                ),
                //search button to call the action
                CustomButton(
                  height: 40,
                  width: deviceWidth / 4.3,
                  onPressed: serachRepos,
                  isIcon: false,
                  buttonText: 'Search',
                ),
              ],
            ),
            SizedBox(height: deviceWidth*0.03),
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
                  return  Expanded(
                    child: Center(
                      child: Text('No repositories found for the search term.',style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: NewRepoCard(
                          listData: snapshot.data!,
                          index: index,
                        ),
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

// This future func get the repos data from the Github API
// And returns the list of repos
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
