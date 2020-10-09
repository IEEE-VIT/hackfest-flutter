import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoCard extends StatelessWidget {
  final List<dynamic> listData;
  final int index;

  RepoCard({this.listData, this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        vertical: 12,
      ),
      shadowColor: Colors.grey[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(listData[index]['owner']['avatar_url']),
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              bottom: 15.0,
              right: 20.0,
              left: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Owner:  ${listData[index]['owner']['login']}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.indigo[200],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Repository:  ${listData[index]['full_name']}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.purple[100],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                listData[index]['description'] != null
                    ? Text(
                        'Description:  ${listData[index]['description']}')
                    : Text('No Description'),
                SizedBox(
                  height: 10,
                ),
                FlatButton.icon(
                    color: Colors.grey[100],
                    splashColor: Colors.indigo[500],
                    onPressed: () async {
                      String url = listData[index]['html_url'];
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: Icon(Icons.visibility),
                    label: Text('Click To Visit'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}