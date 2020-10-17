//A simple About Us page. Changes here are not necessary.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/dictionary.dart';

class InfoPage extends StatefulWidget {
  static String routename = 'InfoPage';
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Center(
                  child: Image.asset(
                    "assets/ieee.png", //IEEE image
                  ),
                ),
                onTap: () => launch(ieevUrl), //Launches the IEEE website
              ),
              Text(ieeeDesc),
              GestureDetector(
                child: Center(
                    child: Container(
                        height: 200,
                        child: SvgPicture.network(hacktoberfestImage))),
                onTap: () => launch(hacktoberfestUrl), //Launches Hacktoberfest site
              ),
              Text(hacktoberfestDesc),
            ],
          ),
        ],
      ),
    );
  }
}
