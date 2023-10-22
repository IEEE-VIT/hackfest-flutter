import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:hacktoberfest_flutter/screens/contributors.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';
import 'package:hacktoberfest_flutter/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class NewRepoCard extends StatelessWidget {
  const NewRepoCard({super.key, required this.listData, required this.index});
  final List<dynamic> listData;
  final int index;

  @override
  Widget build(BuildContext context) {

    Future<void> visitRepo() async {
      final String url = listData[index]['html_url'];
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

    void viewContributors() {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => Contributors(
            repoName: listData[index]['full_name'],
          ),
        ),
      );
    }

    final deviceWidth = MediaQuery.of(context).size.width;
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                if (listData[index]['description'] != null)
                  Text(
                    'Description:  ${listData[index]['description']}',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      height: 35,
                      width: deviceWidth / 4.4,
                      onPressed: visitRepo,
                      isIcon: true,
                      buttonText: 'Visit',
                      color1: Colors.deepPurple.shade800,
                    ),
                    CustomButton(
                      height: 35,
                      width: deviceWidth / 2.6,
                      onPressed: viewContributors,
                      isIcon: true,
                      buttonText: 'Contributors',
                      icon: Icons.people_outline,
                      color1: Colors.deepPurple.shade800,
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
