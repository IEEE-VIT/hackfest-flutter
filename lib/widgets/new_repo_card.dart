import 'package:flutter/material.dart';

import 'package:slimy_card/slimy_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/colors.dart';

class NewRepoCard extends StatelessWidget {
  final List<dynamic> listData;
  final int index;

  NewRepoCard({this.listData, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SlimyCard(
        color: hactoberViolet,
        width: 320,
        topCardHeight: 170,
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
                    )),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text('Owner:  ${listData[index]['owner']['login']}',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 15),
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
                Text('Repository:  ${listData[index]['full_name']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                SizedBox(height: 15),
                listData[index]['description'] != null
                    ? Text(
                        'Description:  ${listData[index]['description']}',
                        style: TextStyle(color: Colors.deepPurple[100]),
                      )
                    : Text('No Description',
                        style: TextStyle(color: Colors.deepPurple[100])),
                SizedBox(height: 15),
                FlatButton.icon(
                    color: Colors.deepPurple[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      String url = listData[index]['html_url'];
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Click To Visit',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
        slimeEnabled: true,
      ),
    );
  }
}
