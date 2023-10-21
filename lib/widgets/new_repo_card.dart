import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/contributors.dart';

class NewRepoCard extends StatelessWidget {
  const NewRepoCard({super.key, required this.listData, required this.index});
  final List<dynamic> listData;
  final int index;

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
                        listData[index]['owner']['avatar_url'],
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
                  'Owner:  ${listData[index]['owner']['login']}',
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
                  'Repository:  ${listData[index]['full_name']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                if (listData[index]['description'] != null)
                  Text(
                    'Description:  ${listData[index]['description']}',
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
                    TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurple[800]!,
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final String url = listData[index]['html_url'];
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      icon: const Icon(
                        Icons.visibility,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Visit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => Contributors(
                              repoName: listData[index]['full_name'],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.people_outline,
                            color: Colors.white,
                          ),
                          Text('Contributors'),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
