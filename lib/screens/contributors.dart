
//Screen to view the list of all the contributors of the project selected in home page


import 'package:flutter/material.dart';

import '../Widgets/contributor_card.dart';
import '../models/contributors_card_model.dart';

class Contributors extends StatelessWidget {
  static final String routename = '/Contributors';
  //List of Contributors who have added their cards
  List <ContributorCard> cardList = [
    ContributorCard(userName:'Contributor 1',desc:'xyz',displayImgUrl:'https://www.cnam.ca/wp-content/uploads/2018/06/default-profile.gif',website: 'www.abc.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Contributors List')),
        backgroundColor: Colors.grey,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ListView.builder(
              // Get the List of contributors to the project from the GitHub Api
              // Append the details of the card to the cardList
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cardList.length,
              itemBuilder:(ctx , index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ContCard(userName: cardList[index].userName,dispImg: cardList[index].displayImgUrl,desc: cardList[index].desc,webSite: cardList[index].website,),
                );
              }
           ),
        ],
      ),
       floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.black,
         child: Icon(Icons.add),
         onPressed: addToContributors,
       ),
    );
  }
}

getContributors(){
  //TODO: Called when the page opens first
  //Append the contributor details to the cardList
}

addToContributors(){
 // TODO: Trigger an alert box or something similar
 // Ask the user to enter the details
 // Adds the user to contributors list
}


