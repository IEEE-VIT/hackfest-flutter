//A simple About Us page. Changes here are not necessary.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/dictionary.dart';

class InfoPage extends StatefulWidget {
  static String routename = 'InfoPage';
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  static const color = Color(0xff13253d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: ListView(
        //padding: EdgeInsets.all(20),
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Center(
                  child: Image.asset(
                    "assets/ieee.png",
                    height: 150, //IEEE image
                  ),
                ),
                onTap: () => launchUrl(Uri.parse(ieevUrl)), //Launches the IEEE website
              ),
              Container(
                height: 20,
              ),
              Text(
                ieeeDesc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Container(
                height: 40,
              ),
              GestureDetector(
                child: Center(
                    child: SizedBox(
                        height: 200,
                        child: SvgPicture.network(hacktoberfestImage))),
                onTap: () =>
                    launchUrl(Uri.parse(hacktoberfestUrl)), //Launches Hacktoberfest site
              ),
            ],
          ),
          Container(
            height: 30,
          ),
          Text(
            hacktoberfestDesc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
