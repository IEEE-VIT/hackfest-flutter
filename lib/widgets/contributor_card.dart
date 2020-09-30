//Widget used to show the contributor card. If you are changing this, make sure the updated design fits in with the design scheme of Hacktoberfest.

import 'package:flutter/material.dart';

class ContCard extends StatelessWidget {
  final String userName;
  final String dispImg;
  final String desc;
  final String webSite;
  ContCard({this.desc,this.userName,this.dispImg,this.webSite});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Image.network(dispImg, height: 100),
            SizedBox(height: 20),
            Text('Username: $userName'),
            SizedBox(height: 10),
              Text('$desc'),
            SizedBox(height: 10),
              Text('WebSite: $webSite'),
            SizedBox(height: 20),
          ],
        ),

      ),
    );
  }
}