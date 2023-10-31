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
  static const color = Color(0xff13253d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Center(
                  child: Image.asset(
                    'assets/IEEE (2).png',
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
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
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
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ],
      ),
    );
  }
}
