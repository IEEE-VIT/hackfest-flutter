import 'package:flutter/material.dart';
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
      backgroundColor: Color(0xFF551A8B),
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
                    "assets/ieee.png",
                    height: 150,
                  ),
                ),
                onTap: () async {
                  try {
                    await launchUrl(Uri.parse(ieevUrl));
                  } catch (e) {
                    print('Error launching URL: $e');
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                ieeeDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18, // Increased font size
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                child: Center(
                  child: Image.network(
                    hacktoberfestImage,
                    height: 200,
                  ),
                ),
                onTap: () => launchUrl(Uri.parse(hacktoberfestUrl)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            hacktoberfestDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18, // Increased font size
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
        ],
      ),
    );
  }
}
