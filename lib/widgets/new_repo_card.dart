import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:hacktoberfest_flutter/models/bookmarked_repo_model.dart';
import 'package:hacktoberfest_flutter/screens/contributors.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewRepoCard extends StatefulWidget {
  const NewRepoCard({super.key, required this.listData, required this.index});
  final List<dynamic> listData;
  final int index;

  @override
  State<NewRepoCard> createState() => _NewRepoCardState();
}

class _NewRepoCardState extends State<NewRepoCard> {
  bool bookmarked = false;

  Future<void> _toggleBookmark() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String repoFullName = widget.listData[widget.index]['full_name'];
    final String repoOwner = widget.listData[widget.index]['owner']['login'];
    final String repoName = widget.listData[widget.index]['name'];
    final String repoDescription = widget.listData[widget.index]['description'];
    final String repoUrl = widget.listData[widget.index]['html_url'];
    final String repoAvatarUrl =
        widget.listData[widget.index]['owner']['avatar_url'];

    final BookmarkedRepository bookmarkedRepo = BookmarkedRepository(
      fullName: repoFullName,
      owner: repoOwner,
      name: repoName,
      description: repoDescription,
      link: repoUrl,
      avatarUrl: repoAvatarUrl,
    );

    final Map<String, dynamic> repoMap = bookmarkedRepo.toMap();

    final List<String> bookmarks = pref.getStringList('bookmark') ?? [];

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

    pref.setStringList('bookmark', bookmarks);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlutterSlimyCard(
        color: hactoberViolet,
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
                        widget.listData[widget.index]['owner']['avatar_url'],
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
                  'Owner:  ${widget.listData[widget.index]['owner']['login']}',
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
                  'Repository:  ${widget.listData[widget.index]['full_name']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                if (widget.listData[widget.index]['description'] != null)
                  Text(
                    'Description:  ${widget.listData[widget.index]['description']}',
                    style: TextStyle(color: Colors.deepPurple[100]),
                  )
                else
                  Text(
                    'No Description',
                    style: TextStyle(color: Colors.deepPurple[100]),
                  ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final String url =
                            widget.listData[widget.index]['html_url'];
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      onPressed: _toggleBookmark,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (bookmarked)
                            const Icon(
                              Icons.bookmarks,
                              color: Colors.white,
                            )
                          else
                            const Icon(
                              Icons.bookmarks_outlined,
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
                          repoName: widget.listData[widget.index]['full_name'],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }
}
