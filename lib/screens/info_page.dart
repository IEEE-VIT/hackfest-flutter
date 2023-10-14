//A simple About Us page. Changes here are not necessary.

import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/shared/dictionary.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);
  static String routename = 'InfoPage';

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  static const color = Color(0xFF0F0913);
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
                    'assets/ieee.png',
                    height: 150, //IEEE image
                  ),
                ),
                onTap: () =>
                    launchUrl(Uri.parse(ieevUrl)), //Launches the IEEE website
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
                    child: Image.network(hacktoberfestImage),
                  ),
                ),
                onTap: () => launchUrl(
                  Uri.parse(hacktoberfestUrl),
                ), //Launches Hacktoberfest site
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
