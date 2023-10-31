import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:hacktoberfest_flutter/models/bookmarked_repo_model.dart';
import 'package:hacktoberfest_flutter/screens/contributors.dart';
import 'package:hacktoberfest_flutter/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});
  static String routename = 'Bookmark';

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  Future<List<BookmarkedRepository>>? bookmarks;
  final bool bookmarked = false;

  @override
  void initState() {
    super.initState();
    bookmarks = loadBookmarks();
  }

  Future<List<BookmarkedRepository>> loadBookmarks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> bookmarkStrings =
        pref.getStringList('bookmarking') ?? [];
    final List<BookmarkedRepository> bookmarks = bookmarkStrings
        .map((item) => BookmarkedRepository.fromMap(json.decode(item)))
        .toList();
    return bookmarks;
  }

  Future<void> removeBookmark(
    BookmarkedRepository repository,
    int index,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> bookmarkStrings =
        prefs.getStringList('bookmarking') ?? [];

    if (index >= 0) {
      bookmarkStrings.removeAt(index);
      prefs.setStringList('bookmarking', bookmarkStrings);
    }
    if (repository.fullName == 'IEEE-VIT/hackfest-flutter') {
      prefs.setBool('bookmarkedState', bookmarked);
    }
    setState(() {
      bookmarks = loadBookmarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder<List<BookmarkedRepository>>(
        future: bookmarks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No bookmarks found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final BookmarkedRepository repo = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterSlimyCard(
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
                                onPressed: () {
                                  removeBookmark(repo, index);
                                },
                                icon: Icon(
                                  bookmarked
                                      ? Icons.bookmark_outline
                                      : Icons.bookmark,
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
                                          repo.avatarUrl,
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
                                      'Owner:  ${repo.owner}',
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
                              'Repository:  ${repo.fullName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Description:  ${repo.description}',
                              style: TextStyle(
                                color: Colors.deepPurple[100],
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
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
                                      final String url = repo.link;
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
                                            repoName: repo.fullName,
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
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
