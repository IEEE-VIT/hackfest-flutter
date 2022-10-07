import 'dart:convert';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github_flutter/constants/assets.dart';
import 'package:github_flutter/data/fake_data.dart';
import 'package:github_flutter/models/github_repo_model.dart';
import 'package:github_flutter/providers/theme_provider.dart';
import 'package:github_flutter/shared/colors.dart';
import 'package:github_flutter/widgets/repo_widget.dart';
import 'package:github_flutter/widgets/tap_effect.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController controller;

  Future<List> listOfRepos;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (c, bo) => [
            SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      // width: w * 0.3,
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        Assets.logo,
                        color: Provider.of<ThemeProvider>(context).isDarkTheme
                            ? Colors.white
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
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
                    },
                  )
                ],
              ),
            ),
            SliverAppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: true,
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            isDense: true,
                            fillColor: Colors.white,
                            hintText: 'Search Here',
                          ),
                          textInputAction: TextInputAction.search,
                          onEditingComplete: search,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TapEffect(
                      onClick: search,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [hactoberViolet, hacktoberPink],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(FeatherIcons.search, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: FutureBuilder<List<dynamic>>(
            future: listOfRepos,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                //this widget display the repos details
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data.length,
                  separatorBuilder: (c, i) => SizedBox(height: 10),
                  itemBuilder: (c, i) => RepoWidget(
                    data: GithubRepoModel.fromResponse(snapshot.data[i]),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCube(
                    color: Colors.grey,
                    size: 50.0,
                  ),
                );
              }

              //loading spinner
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
              );
            },
          ),
        ),
      ),
    );
  }

  void search() {
    if (controller.text != null) {
      FocusScope.of(context).unfocus();
      setState(() {
        setState(() {
          listOfRepos = getRepos(controller.text);
        });
      });
    } else {
      return null;
    }
  }

//This future func get the repos data from the Github API
//And returns the list of repos
  Future<List> getRepos(String tag) async {
    final String baseURL =
        "https://api.github.com/search/repositories?q=" + tag;
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
}
