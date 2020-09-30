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
        child: ListTile(
          title:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Username: $userName'),
              Text('$desc'),
              Text('WebSite: $webSite'),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(dispImg),
          ),
        ),
      ),
    );
  }
}