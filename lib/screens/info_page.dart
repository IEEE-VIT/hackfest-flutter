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

  String ieeeDesc = "IEEE VIT is one of the most active student chapters inside Region 10 of IEEE International. "
      "We're a diverse group of tech enthusiasts, developers and designers.";

  String hacktoberfestDesc = "Hacktoberfest is open to everyone in our global community. Whether you’re a developer, "
      "student learning to code, event host, or company of any size, you can help drive growth of open source and make"
      " positive contributions to an ever-growing community. ";

  String hacktoberfestImage = "https://hacktoberfest.digitalocean.com/assets/HF-full-logo-b05d5eb32b3f3ecc9b2240526104cf4da3187b8b61963dd9042fdc2536e4a76c.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Center(
                child: Text('IEEE',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 60,
                    color: Colors.pink[200]
                  ),
                )
              ),
              onTap: () => launch('https://ieeevit.org'), //Launches the IEEE website
            ),
            Text(ieeeDesc,
              style: TextStyle(
                fontSize: 15,
                color: Colors.indigo[100],
                
              ),
            ),
            GestureDetector(
              child: Center(
                  child: Container(
                    height: 200,
                      child: SvgPicture.network(hacktoberfestImage))),
              onTap: () => launch('https://hacktoberfest.digitalocean.com'), //Launches Hacktoberfest site
            ),
            Text(hacktoberfestDesc,
              style: TextStyle(
                fontSize: 15,
                color: Colors.indigo[100],
              ),),
          ],
        ),
      ),
    );
  }
}
