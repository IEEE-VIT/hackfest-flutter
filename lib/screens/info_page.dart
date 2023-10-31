import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:hacktoberfest_flutter/models/bookmarked_repo_model.dart';
import 'package:hacktoberfest_flutter/screens/contributors.dart';
import 'package:hacktoberfest_flutter/shared/dictionary.dart';
import 'package:hacktoberfest_flutter/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);
  static String routename = 'InfoPage';

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool bookmarked = false;

  Future<void> _toggleBookmark(
    String repoFullName,
    String repoOwner,
    String repoName,
    String repoDescription,
    String repoUrl,
    String repoAvatarUrl,
  ) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final BookmarkedRepository bookmarkedRepo = BookmarkedRepository(
      fullName: repoFullName,
      owner: repoOwner,
      name: repoName,
      description: repoDescription,
      link: repoUrl,
      avatarUrl: repoAvatarUrl,
    );

    final Map<String, dynamic> repoMap = bookmarkedRepo.toMap();

    final List<String> bookmarks = pref.getStringList('bookmarking') ?? [];

    if (bookmarks.any((item) {
      final Map<String, dynamic> repoMap =
          json.decode(item); // Deserialize the JSON string
      return repoMap['fullName'] == repoFullName;
    })) {
      // Remove the bookmark
      bookmarks.removeWhere((item) {
        final Map<String, dynamic> repoMap =
            json.decode(item); // Deserialize the JSON string
        return repoMap['fullName'] == repoFullName;
      });
      setState(() {
        bookmarked = false;
      });
    } else {
      // Add the bookmark
      bookmarks.add(json.encode(repoMap));
      setState(() {
        bookmarked = true;
      });
    }

    pref.setStringList('bookmarking', bookmarks);
    pref.setBool('bookmarkedState', bookmarked);
  }

  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences for 'bookmarkedState'
    SharedPreferences.getInstance().then((prefs) {
      final bool isBookmarked = prefs.getBool('bookmarkedState') ?? false;
      setState(() {
        bookmarked = isBookmarked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'IEEE-VIT Student Chapter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              GestureDetector(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/IEEE.png',
                      fit: BoxFit.fill,
                      // height: 200,
                      width: deviceWidth / 2.0,
                    ),
                  ),
                ),
                onTap: () =>
                    launchUrl(Uri.parse(ieevUrl)), //Launches the IEEE website
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                ieeeDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'IEEE-VIT Repositories',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: getRepositoryDetails('IEEE-VIT', 'hackfest-flutter'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final repoData = snapshot.data;

                    return FlutterSlimyCard(
                      color: Theme.of(context).canvasColor,
                      cardWidth: deviceWidth * 0.88,
                      topCardHeight: 150,
                      bottomCardHeight: 250,
                      borderRadius: 15,
                      topCardWidget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () async {
                                  _toggleBookmark(
                                    repoData?['full_name'],
                                    repoData?['owner']['login'],
                                    repoData?['name'],
                                    repoData!['description'].toString(),
                                    repoData['html_url'],
                                    repoData['owner']['avatar_url'],
                                  );
                                },
                                icon: Icon(
                                  bookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    height: 80,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          repoData?['owner']['avatar_url'],
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Owner:  ${repoData?['owner']['login']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      bottomCardWidget: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Repository:  ${repoData?['full_name']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            if (repoData?['description'] != null)
                              Text(
                                'Description:  ${repoData?['description']}',
                                style: TextStyle(
                                  color: Colors.deepPurple[100],
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )
                            else
                              Text(
                                'No Description',
                                style: TextStyle(color: Colors.deepPurple[100]),
                              ),
                            const SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                    height: 35,
                                    width: deviceWidth / 4.4,
                                    onPressed: () async {
                                      final String url = repoData?['html_url'];
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    isIcon: true,
                                    buttonText: 'Visit',
                                  ),
                                  CustomButton(
                                    height: 35,
                                    width: deviceWidth / 2.6,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) => Contributors(
                                            repoName: repoData?['full_name'],
                                          ),
                                        ),
                                      );
                                    },
                                    isIcon: true,
                                    buttonText: 'Contributors',
                                    icon: Icons.people_outline,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          Container(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                height: 35,
                width: deviceWidth / 4.4,
                onPressed: () async {
                  const String url =
                      'https://github.com/IEEE-VIT/hackfest-flutter';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                isIcon: true,
                buttonText: 'Visit',
              ),
              CustomButton(
                height: 35,
                width: deviceWidth / 2.4,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => const Contributors(
                        repoName: 'IEEE-VIT/hackfest-flutter',
                      ),
                    ),
                  );
                },
                isIcon: true,
                buttonText: 'Contributors',
                icon: Icons.people_outline,
              ),
              CustomButton(
                height: 35,
                width: deviceWidth / 4.1,
                onPressed: () async {
                  const String url = 'https://github.com/IEEE-VIT';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                isIcon: true,
                icon: Icons.follow_the_signs,
                buttonText: 'Follow',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<Map<String, dynamic>> getRepositoryDetails(
  String owner,
  String repoName,
) async {
  final String baseURL = 'https://api.github.com/repos/$owner/$repoName';
  final response = await http.get(
    Uri.parse(Uri.encodeFull(baseURL)),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> result = jsonDecode(response.body);
    return result;
  } else {
    throw Exception('Failed to fetch repository details');
  }
}
