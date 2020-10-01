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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.blueGrey[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(dispImg),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                Text(userName,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10),
                Text('$desc',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.indigo[100],
                  ),),
                SizedBox(height: 10),
                Text('$webSite',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.pink[400],

                  ),),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),

      ),
    );
  }
}