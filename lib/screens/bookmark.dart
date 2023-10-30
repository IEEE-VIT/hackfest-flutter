import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:hacktoberfest_flutter/models/bookmarked_repo_model.dart';
import 'package:hacktoberfest_flutter/screens/contributors.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';
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
    final List<String> bookmarkStrings = pref.getStringList('bookmark') ?? [];
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
    final List<String> bookmarkStrings = prefs.getStringList('bookmark') ?? [];
    // final int indexToRemove = bookmarkStrings.indexWhere((item) {
    //   final Map<String, dynamic> repoMap = json.decode(item);
    //   return repoMap['fullName'] == repository.fullName;
    // });

    if (index >= 0) {
      bookmarkStrings.removeAt(index);
      prefs.setStringList('bookmark', bookmarkStrings);
    }
    setState(() {
      bookmarks = loadBookmarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      color: hacktoberViolet,
                      topCardHeight: 230,
                      bottomCardHeight: 250,
                      borderRadius: 15,
                      topCardWidget: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
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
                              const SizedBox(height: 15),
                              Text(
                                'Owner:  ${repo.owner}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                      bottomCardWidget: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Repository:  ${repo.fullName}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Description:  ${repo.description}',
                                style: TextStyle(color: Colors.deepPurple[100]),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      final String url = repo.link;
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.deepPurple.shade800,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 7),
                                          child: Text(
                                            'Visit',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      removeBookmark(repo, index);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.deepPurple.shade800,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          bookmarked == true
                                              ? Icons.bookmarks_outlined
                                              : Icons.bookmarks,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.people_outline,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 7),
                                      child: Text('Contributors'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
