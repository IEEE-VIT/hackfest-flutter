//Widget used to show the contributor card. If you are changing this, make sure the updated design fits in with the design scheme of Hacktoberfest.

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
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
      child: Card(dispImg: dispImg, userName: userName, desc: desc, webSite: webSite),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key key,
    @required this.dispImg,
    @required this.userName,
    @required this.desc,
    @required this.webSite,
  }) : super(key: key);

  final String dispImg;
  final String userName;
  final String desc;
  final String webSite;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL, // default
      front: Padding(
        padding: const EdgeInsets.only(left:6,right: 6),
        child: Container(

          decoration:  BoxDecoration(
            color: Colors.grey,
              borderRadius:  BorderRadius.all(Radius.circular(10.0),),),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Image.network(dispImg, height: 100),
              SizedBox(height: 20),
              Text('Username: $userName',style: TextStyle(color: Colors.white),),
              SizedBox(height: 10),

            ],
          ),
        ),
      ),
      back: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:  BoxDecoration(
            color: Colors.grey,
            borderRadius:  BorderRadius.all(Radius.circular(10.0),),),
          child: Column(
            children: <Widget>[

              SizedBox(height: 40),
              Text('$desc',style: TextStyle(color: Colors.white),),
              SizedBox(height: 40),
              Text('WebSite: $webSite',style: TextStyle(color: Colors.white),),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}



