//A simple About Us page. Changes here are not necessary.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  static String routename  = 'InfoPage';
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Center(
                child: Image.asset(
                  "assets/ieeevit.png", //IEEE image
                ),
              ),
              onTap: () => launch('https://ieeevit.org'), //Launches the IEEE website
            ),
            GestureDetector(
              child: Center(
                  child: Container(
                      child: SvgPicture.network('https://hacktoberfest.digitalocean.com/assets/HF-full-logo-b05d5eb32b3f3ecc9b2240526104cf4da3187b8b61963dd9042fdc2536e4a76c.svg'))),
              onTap: () => launch('https://hacktoberfest.digitalocean.com'), //Launches Hacktoberfest site
            ),
          ],
        ),
      ),
    );
  }
}
